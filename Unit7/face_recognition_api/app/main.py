from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import base64
import numpy as np
import cv2
import face_recognition
import mysql.connector
import json
import os
from fastapi.responses import StreamingResponse
import asyncio

# ---------------------- CONFIG ----------------------
DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "face_db")
}

# ---------------------- FASTAPI SETUP ----------------------
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict this
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------------------- MODELS ----------------------
class FaceRegister(BaseModel):
    name: str
    image: str  # base64 encoded image

class FaceRecognize(BaseModel):
    image: str  # base64 encoded image

# ---------------------- UTILITIES ----------------------
def decode_image(base64_string):
    try:
        img_data = base64.b64decode(base64_string)
        np_arr = np.frombuffer(img_data, np.uint8)
        img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
        return img
    except Exception:
        return None

def connect_db():
    return mysql.connector.connect(**DB_CONFIG)

def get_face_encoding(image):
    rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    faces = face_recognition.face_locations(rgb)
    encodings = face_recognition.face_encodings(rgb, faces)
    return encodings[0] if encodings else None

def detect_liveness(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blur = cv2.Laplacian(gray, cv2.CV_64F).var()
    return blur > 100.0  # empirical threshold

# ---------------------- ROUTES ----------------------
@app.post("/register")
async def register_face(data: FaceRegister):
    img = decode_image(data.image)
    if img is None:
        raise HTTPException(status_code=400, detail="Invalid image data")

    if not detect_liveness(img):
        raise HTTPException(status_code=400, detail="Liveness check failed. Present a real face, not a photo.")

    encoding = get_face_encoding(img)
    if encoding is None:
        raise HTTPException(status_code=400, detail="No face detected")

    await asyncio.to_thread(save_encoding_to_db, data.name, encoding)

    return {"message": f"Face registered for {data.name}"}

@app.post("/recognize")
async def recognize_face(data: FaceRecognize):
    img = decode_image(data.image)
    if img is None:
        raise HTTPException(status_code=400, detail="Invalid image data")

    if not detect_liveness(img):
        raise HTTPException(status_code=400, detail="Liveness check failed. Present a real face, not a photo.")

    encoding = get_face_encoding(img)
    if encoding is None:
        raise HTTPException(status_code=400, detail="No face detected")

    known_names, known_encodings = await asyncio.to_thread(load_known_faces)

    distances = face_recognition.face_distance(known_encodings, encoding)
    best_match_index = np.argmin(distances) if len(distances) > 0 else None
    name = "Unknown"

    if best_match_index is not None and distances[best_match_index] <= 0.6:
        name = known_names[best_match_index]

    return {
        "name": name,
        "confidence": float(1 - distances[best_match_index]) if best_match_index is not None else None,
        "distance": float(distances[best_match_index]) if best_match_index is not None else None
    }

@app.get("/faces")
async def list_faces():
    def query():
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM registered_faces")
        names = [row[0] for row in cursor.fetchall()]
        conn.close()
        return names

    names = await asyncio.to_thread(query)
    return {"registered": names}

# ---------------------- DATABASE HELPERS ----------------------
def save_encoding_to_db(name, encoding):
    conn = connect_db()
    cursor = conn.cursor()
    encoding_json = json.dumps(encoding.tolist())
    cursor.execute("INSERT INTO registered_faces (name, encoding) VALUES (%s, %s)", (name, encoding_json))
    conn.commit()
    conn.close()

def load_known_faces():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name, encoding FROM registered_faces")
    names = []
    encodings = []
    for name, enc_str in cursor.fetchall():
        names.append(name)
        encodings.append(json.loads(enc_str))
    conn.close()
    return names, encodings

# ---------------------- UNIT TEST HOOK ----------------------
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("__main__:app", host="0.0.0.0", port=8000, reload=True)
