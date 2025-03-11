#!/bin/bash

# Start the XFCE session
startxfce4 &

# Start x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &

# Start noVNC
/opt/noVNC/utils/launch.sh --vnc localhost:5900 &

# Start webrtcvnc
/opt/webrtcvnc/webrtcvnc --vnc localhost:5900 &

# Keep the container running
tail -f /dev/null
