# Face Recognition API (Docker + FastAPI + MySQL)

## Endpoints
- `POST /register` → Register face with `{ name, image (base64) }`
- `POST /recognize` → Identify a face from a base64 image
- `GET /faces` → List all registered face names

## Usage

```bash
docker-compose build
docker-compose up
