#!/bin/bash
set -e

# Install XFCE desktop environment and VNC server tooling for headless GUI access
echo "Installing XFCE desktop and VNC server tooling..."
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dbus-x11 \
    procps \
    sudo \
    xfce4 \
    xfce4-goodies \
    xvfb \
    x11-apps \
    x11-utils \
    x11-xserver-utils \
    x11vnc \
    && rm -rf /var/lib/apt/lists/*

# Install core build dependencies required by AirSim and Unreal Engine workflow
echo "Installing AirSim build dependencies..."
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    git \
    git-lfs \
    libvulkan-dev \
    ninja-build \
    python3-pip \
    unzip \
    vulkan-tools \
    && rm -rf /var/lib/apt/lists/*

echo "XFCE, VNC server, and AirSim dependencies installed successfully."
