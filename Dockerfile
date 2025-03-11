# Use the official Debian image as a parent image
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update -y && \
    apt-get install -y \
    wget \
    curl \
    gnupg \
    sudo \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    xfce4-session \
    xfce4-power-manager \
    xfce4-whiskermenu-plugin \
    xfce4-weather-plugin \
    xfce4-volumed \
    xfce4-volumed-pulse \
    pulseaudio \
    pulseaudio-module-x11 \
    pavucontrol \
    x11vnc \
    novnc \
    webrtcvnc \
    sudo \
    gnome-games \
    telegram-desktop \
    gdebi \
    gedit \
    gimp \
    inkscape \
    kdenlive \
    krita \
    lollypop \
    notepadqq \
    obs-studio \
    thunderbird \
    vim \
    openjdk-11-jdk \
    android-sdk \
    torbrowser-launcher \
    olive-video-editor \
    audacity \
    blender \
    chromium \
    libreoffice \
    vim \
    numix-gtk-theme \
    numix-icon-theme \
    && \
    rm -rf /var/lib/apt/lists/*

# Create a user and set up sudo
RUN useradd -m hozoo && \
    echo "hozoo:hozoo" | chpasswd && \
    usermod -aG sudo hozoo

# Set up noVNC
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -xzf /tmp/noVNC.tar.gz -C /opt && \
    rm /tmp/noVNC.tar.gz && \
    ln -s /opt/noVNC-1.3.0 /opt/noVNC

# Set up x11vnc
RUN wget https://github.com/LibVNC/x11vnc/archive/refs/tags/v0.9.16.tar.gz -O /tmp/x11vnc.tar.gz && \
    tar -xzf /tmp/x11vnc.tar.gz -C /opt && \
    rm /tmp/x11vnc.tar.gz && \
    ln -s /opt/x11vnc-0.9.16 /opt/x11vnc

# Set up webrtcvnc
RUN wget https://github.com/novnc/webrtcvnc/archive/refs/tags/v0.6.0.tar.gz -O /tmp/webrtcvnc.tar.gz && \
    tar -xzf /tmp/webrtcvnc.tar.gz -C /opt && \
    rm /tmp/webrtcvnc.tar.gz && \
    ln -s /opt/webrtcvnc-0.6.0 /opt/webrtcvnc

# Set up the desktop environment
RUN echo "xfce4-session" > /etc/skel/.xsession

# Set up the startup script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Install additional applications
RUN wget https://i.ibb.co.com/bjvyS5zj/anime-anime-girls-sword-red-fan-art-hd-wallpaper-preview.jpg -O /home/hozoo/background.jpg && \
    wget https://raw.githubusercontent.com/wahasa/Ubuntu/main/Apps/chromiumfix.sh ; chmod +x chromiumfix.sh ; ./chromiumfix.sh && \
    wget https://raw.githubusercontent.com/wahasa/Ubuntu/main/Apps/libreofficefix.sh ; chmod +x libreofficefix.sh ; ./libreofficefix.sh && \
    wget https://raw.githubusercontent.com/wahasa/Ubuntu/main/Apps/vscodefix.sh ; chmod +x vscodefix.sh ; ./vscodefix.sh

# Install Tor Browser
RUN apt-get install -y apt-transport-https curl && \
    curl -s https://deb.torproject.org/torproject.org/keys/tor-archive.key | gpg --dearmor -o /usr/share/keyrings/tor-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org stable main" | tee /etc/apt/sources.list.d/torproject.list && \
    apt-get update -y && \
    apt-get install -y torbrowser-launcher

# Install Android Studio
RUN wget https://dl.google.com/dl/android/studio/install/2021.1.1.20/android-studio-2021.1.1.20-linux.tar.gz -O /tmp/android-studio.tar.gz && \
    tar -xzf /tmp/android-studio.tar.gz -C /opt && \
    ln -s /opt/android-studio /opt/android-studio && \
    rm /tmp/android-studio.tar.gz

# Install Olive Video Editor
RUN add-apt-repository ppa:olive-editor/olive-editor && \
    apt-get update -y && \
    apt-get install -y olive-video-editor

# Expose the necessary ports
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/start.sh"]
