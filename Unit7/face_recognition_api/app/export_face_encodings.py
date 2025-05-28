import mysql.connector
import json
import pandas as pd

# MySQL connection details
conn = mysql.connector.connect(
    host="localhost",
    port=43306,  # or 43306 on Synology
    user="root",
    password="mypass",
    database="face_db"
)

cursor = conn.cursor()
cursor.execute("SELECT name, encoding FROM registered_faces")
rows = cursor.fetchall()

data = []
for name, encoding_json in rows:
    encoding = json.loads(encoding_json)
    row = {"name": name}
    for i, val in enumerate(encoding):
        row[f"v{i+1}"] = val
    data.append(row)

df = pd.DataFrame(data)
df.to_csv("face_encodings_export.csv", index=False)

cursor.close()
conn.close()

print("Exported face_encodings_export.csv")
