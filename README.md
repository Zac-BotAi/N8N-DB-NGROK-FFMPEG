# N8N-DB-NGROK-FFMPEG
A self-hosted n8n instance on Render with full FFmpeg support — use it to build workflows that process video and audio (merge, overlay, inspect, or custom commands) and interface with external services via webhooks.


# n8n + FFmpeg on Render

This repository runs n8n on Render, enhanced with FFmpeg support and community FFmpeg nodes. Use this setup to process media files within n8n workflows—ideal for tasks like video merging, audio overlay, metadata extraction, or running custom FFmpeg commands.

### 🚀 Features
- **FFmpeg integration** (system-level + FFmpeg n8n node)
  - Merge videos
  - Overlay audio onto video
  - Retrieve media info (streams, codecs, metadata)
  - Execute custom FFmpeg commands :contentReference[oaicite:3]{index=3}
- Hosted and containerized via Render (using `render.yaml`)
- Public-facing via your `WEBHOOK_URL`, enabling Telegram, Google OAuth, and other webhook-based integrations
- Easily extendable: drop in additional CLI tools (ImageMagick, etc.) by extending `Dockerfile`

---

## 🛠️ Getting Started

### 1. Install FFmpeg & FFmpeg Node  
Ensure your Dockerfile includes:

```dockerfile
FROM n8nio/n8n:latest
USER root
RUN apt-get update \
  && apt-get install -y ffmpeg \
  && npm install --prefix /usr/local/lib/node_modules/n8n n8n-nodes-ffmpeg \
  && rm -rf /var/lib/apt/lists/*
USER node
