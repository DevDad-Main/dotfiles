#!/bin/bash

# Define output folder and filename with timestamp
OUTPUT_DIR="$HOME/Videos"
FILENAME="recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
OUTPUT_PATH="$OUTPUT_DIR/$FILENAME"

# Check if gpu-screen-recorder is already running
PID=$(pgrep -f "gpu-screen-recorder -w screen")

if [ -z "$PID" ]; then
  # Not running → start recording in background
  mkdir -p "$OUTPUT_DIR"
  gpu-screen-recorder -w screen -c mp4 -f 60 -encoder cpu -o "$OUTPUT_PATH" &
  notify-send "Recording started to $OUTPUT_PATH"
else
  # Running → kill the process (stop recording)
  kill $PID &
  notify-send "Recording stopped and saved to $OUTPUT_PATH"
fi
