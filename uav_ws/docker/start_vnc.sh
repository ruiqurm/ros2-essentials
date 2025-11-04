#!/usr/bin/env bash
set -euo pipefail

# Launch a virtual framebuffer, XFCE session, and x11vnc server for remote desktop access.

DISPLAY="${DISPLAY:-:1}"
VNC_PORT="${VNC_PORT:-5900}"
VNC_GEOMETRY="${VNC_GEOMETRY:-1920x1080}"
VNC_DEPTH="${VNC_DEPTH:-24}"

XVFB_OPTS=("$DISPLAY" "-screen" "0" "${VNC_GEOMETRY}x${VNC_DEPTH}")

cleanup() {
    # Stop background processes on exit to avoid orphaned servers.
    if [[ -n "${XFCE_PID:-}" ]]; then
        kill "$XFCE_PID" 2>/dev/null || true
    fi
    if [[ -n "${XVFB_PID:-}" ]]; then
        kill "$XVFB_PID" 2>/dev/null || true
    fi
}
trap cleanup EXIT

# Start virtual framebuffer for headless GUI rendering.
if ! pgrep -x Xvfb >/dev/null; then
    Xvfb "${XVFB_OPTS[@]}" &
    XVFB_PID=$!
    # Allow the server a moment to initialize the display.
    sleep 2
fi

# Launch XFCE desktop environment.
dbus-launch --exit-with-session startxfce4 &
XFCE_PID=$!

# Configure VNC authentication if requested.
VNC_AUTH_ARGS=("-nopw")
if [[ -n "${VNC_PASSWORD:-}" ]]; then
    mkdir -p ~/.vnc
    x11vnc -storepasswd "$VNC_PASSWORD" ~/.vnc/passwd
    VNC_AUTH_ARGS=("-rfbauth" "$HOME/.vnc/passwd")
fi

echo "VNC server listening on port ${VNC_PORT} with display ${DISPLAY} (${VNC_GEOMETRY}x${VNC_DEPTH})"
x11vnc \
    -display "$DISPLAY" \
    -forever \
    -shared \
    -rfbport "$VNC_PORT" \
    "${VNC_AUTH_ARGS[@]}"
