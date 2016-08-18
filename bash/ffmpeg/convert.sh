#!/bin/bash
FILES=./123/*
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  ffmpeg -v 5 -y -i "$f" -acodec libmp3lame -ac 2 -ab 192k "$f".mp3
#  ffmpeg -i "./123/$f" -vcodec libx264 -vprofile high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -acodec libfaac -ab 128k "./mp4s/$MP4FILENAME" < /dev/null
done
