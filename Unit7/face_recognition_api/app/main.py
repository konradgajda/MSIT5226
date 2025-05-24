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
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

def get_face_encoding(image):
    rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    faces = face_recognition.face_locations(rgb)
    encodings = face_recognition.face_encodings(rgb, faces)
    return encodings[0] if encodings else None

# ---------------------- ROUTES ----------------------
@app.post("/register")
def register_face(data: FaceRegister):
    img = decode_image(data.image)
    if img is None:
        raise HTTPException(status_code=400, detail="Invalid image data")

    encoding = get_face_encoding(img)
    if encoding is None:
        raise HTTPException(status_code=400, detail="No face detected")

    conn = connect_db()
    cursor = conn.cursor()

    # Check for duplicate name
    cursor.execute("SELECT COUNT(*) FROM registered_faces WHERE name = %s", (data.name,))
    if cursor.fetchone()[0] > 0:
        conn.close()
        raise HTTPException(status_code=400, detail="Name already exists. Please choose a different name.")

    encoding_json = json.dumps(encoding.tolist())
    cursor.execute("INSERT INTO registered_faces (name, encoding) VALUES (%s, %s)", (data.name, encoding_json))
    conn.commit()
    conn.close()

    return {"message": f"Face registered for {data.name}"}

@app.post("/recognize")
def recognize_face(data: FaceRecognize):
    img = decode_image(data.image)
    if img is None:
        raise HTTPException(status_code=400, detail="Invalid image data")

    encoding = get_face_encoding(img)
    if encoding is None:
        raise HTTPException(status_code=400, detail="No face detected")

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name, encoding FROM registered_faces")
    known_names = []
    known_encodings = []

    for name, enc_str in cursor.fetchall():
        known_names.append(name)
        known_encodings.append(json.loads(enc_str))

    conn.close()

    matches = face_recognition.compare_faces(known_encodings, encoding)
    name = "Unknown"
    if True in matches:
        idx = matches.index(True)
        name = known_names[idx]

    return {"name": name}

@app.get("/faces")
def list_faces():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM registered_faces")
    names = [row[0] for row in cursor.fetchall()]
    conn.close()
    return {"registered": names}

# ---------------------- UNIT TEST HOOK ----------------------
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("__main__:app", host="0.0.0.0", port=8000, reload=True)
