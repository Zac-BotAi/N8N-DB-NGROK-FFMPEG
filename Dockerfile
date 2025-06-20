FROM n8nio/n8n:latest
USER root

# media & image support
apt-get update \
 && apt-get install -y ffmpeg imagemagick ghostscript exiftool

# FFmpeg node
npm install --prefix /usr/local/lib/node_modules/n8n n8n-nodes-ffmpeg

# security: drop root and cleanup
rm -rf /var/lib/apt/lists/*
USER node
