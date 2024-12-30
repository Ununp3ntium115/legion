# Start from a standard Ubuntu base
FROM ubuntu:22.04

# Configure environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
ENV DISPLAY :0

# Update apt, install essential packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        build-essential \
        nmap \
        libegl1 \
        libdbus-1-3 \
        libx11-6 \
        libglib2.0-0 \
        libqt5widgets5 \
        libqt5gui5 \
        libqt5core5a \
        libgl1 \
        libxkbcommon-x11-0 \
        libsm6 \
        libxext6 \
        libxrender-dev \
        libfontconfig1 \
        libxcb-xinerama0 \
        libxcb-cursor0 \
        libxcb-render0-dev \
        libxcb-shm0-dev \
        libxcb1-dev && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory for Legion
WORKDIR /legion

# Clone the Legion repo into a temp folder, then move it into /legion
RUN git clone https://github.com/GoVanguard/legion.git /tmp/legion && \
    cp -r /tmp/legion/* /legion && \
    rm -rf /tmp/legion

# Make scripts executable; create /legion/tmp
RUN chmod +x ./startLegion.sh && \
    chmod +x ./deps/* -R && \
    chmod +x ./scripts/* -R && \
    mkdir -p /legion/tmp

# Upgrade pip, install Python dependencies
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install --upgrade -r requirements.txt

# Run the detectScripts to finish setup
RUN ./deps/detectScripts.sh

# The container will default to running legion.py
CMD ["python3", "legion.py"]
