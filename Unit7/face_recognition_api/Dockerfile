FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN apt-get update && apt-get install -y \
    build-essential cmake libglib2.0-0 libsm6 libxrender1 libxext6 \
    libgl1-mesa-glx libgl1 libgtk2.0-dev \
    && pip install --no-cache-dir -r requirements.txt

COPY ./app ./app
WORKDIR /app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
