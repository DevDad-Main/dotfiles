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
  # Using 30fps here as i mostly use it for github gifs and anything above is super slow - 30FPS plays at a standard rate. Change to 60 if you wish
  gpu-screen-recorder -w screen -c mp4 -f 30 -encoder cpu -o "$OUTPUT_PATH" &
  notify-send "Recording started..." "Recording to $OUTPUT_PATH"
else
  notify-send "Recording stopped.." "Recording saved to $OUTPUT_PATH"
  # Running → kill the process (stop recording)
  kill $PID &
fi
