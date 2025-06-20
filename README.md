# N8N-DB-NGROK-FFMPEG
A self-hosted n8n instance on Render with full FFmpeg support — use it to build workflows that process video and audio (merge, overlay, inspect, or custom commands) and interface with external services via webhooks.


# n8n + Media Tools on Render

Self-hosted **n8n** on Render, with media processing (FFmpeg, ImageMagick, ExifTool, Ghostscript, yt-dlp, SoX), CI/CD, and public webhooks via ngrok.

## 🚀 Features

- **FFmpeg** + community node for audio/video operations
- **ImageMagick** & **Ghostscript** for powerful image/PDF workflows
- **ExifTool** for metadata handling
- **yt-dlp** for downloading media
- **SoX** for advanced audio editing
- **Telegram Trigger**, **Google Drive/Calendar** integrations with secure webhooks via ngrok
- **CI/CD** with GitHub Actions: build, scan (Trivy), and deploy to Render
- **Security automation**: container scans, Dependabot/Snyk for deps

---

## 🧰 Requirements

- Render account
- ngrok account & `NGROK_TOKEN`
- GitHub repo (connected to Render)
- Google & Telegram API credentials

---

## 🛠 Setup Overview

1. **Clone the repo**  
2. Copy `.env.example` → `.env` with:
NGROK_TOKEN=...
TELEGRAM_BOT_TOKEN=...
GOOGLE_CLIENT_ID=...
GOOGLE_CLIENT_SECRET=...
3. **Dockerfile** includes all necessary tools.
4. **render.yaml** configures the n8n + Postgres services.
5. **CI/CD workflow** (GitHub Actions) builds, scans, deploys on push to `main`.
6. **ngrok** runs on startup to expose `WEBHOOK_URL`.

---

Create the n8n-secrets envVarGroup in Render UI, adding:

TELEGRAM_BOT_TOKEN

GOOGLE_CLIENT_ID

GOOGLE_CLIENT_SECRET

NGROK_TOKEN

Push this render.yaml update to your repo’s main branch.

Render will:

Recognize the new blueprint.

Apply settings to production.

Automatically spin up preview environments (for PRs) with the same configuration.

Configure any additional preview-specific logic in n8n, e.g. redirect URLs based on API_ENDPOINT.

Let me know if you want help scripting database resets in previews or customizing workflows per environment!

---

## 🧩 Dockerfile 

```dockerfile
FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache \
ffmpeg imagemagick ghostscript exiftool yt-dlp sox perl \
&& npm install -g n8n-nodes-ffmpeg

# Clean up
USER node
