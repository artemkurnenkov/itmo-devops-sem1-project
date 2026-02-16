#!/bin/bash
set -e

echo "Starting app."
go run main.go &

echo "Waiting for the server to be ready."
for i in {1..10}; do
  if curl -s http://localhost:8080 &> /dev/null; then
    echo "Server successfully started!"
    exit 0
  fi
  echo "Attempt $i: waiting for the server..."
  sleep 5
done

echo "Error: server did not start in time."
exit 1
