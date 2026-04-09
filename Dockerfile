FROM python:3.9-slim

# Modern system dependencies for OpenCV/AI models
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Requirements install
# Ensure api/requirements.txt exists in your repo
COPY api/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && pip install --no-cache-dir uvicorn python-dotenv azure-storage-blob flask-cors

COPY . /app

# Port 5000 for standard compliance
EXPOSE 5000

# Updated port to 5000 and ensured app-dir points to your src
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860", "--app-dir", "api/src"]
