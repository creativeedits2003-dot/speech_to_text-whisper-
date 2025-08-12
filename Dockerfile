FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system packages for sounddevice, ffmpeg, and whisper
RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    portaudio19-dev \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Copy files
COPY requirements.txt .

# Upgrade pip & install Python deps
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# Copy app code
COPY . .

# Expose port for Gradio
EXPOSE 7860

# Run the app
CMD ["python", "speechtotext.py"]
