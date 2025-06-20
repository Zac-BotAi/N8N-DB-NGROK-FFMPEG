#!/usr/bin/env bash
set -e

# 1. Authenticate ngrok
if [ -n "$NGROK_TOKEN" ]; then
  ngrok authtoken "$NGROK_TOKEN"
else
  echo "🚫 NGROK_TOKEN not set!"
  exit 1
fi

# 2. Start ngrok to expose n8n (runs in background)
ngrok http 5678 --log=stdout &

# 3. Start n8n (default CMD)
exec n8n
