FROM n8nio/n8n:latest
USER root

# Install media & tools
RUN apt-get update \
  && apt-get install -y ffmpeg imagemagick ghostscript exiftool yt-dlp sox curl \
  && npm install --prefix /usr/local/lib/node_modules/n8n n8n-nodes-ffmpeg \
  && rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Use start.sh as entrypoint
ENTRYPOINT ["/start.sh"]
USER node
