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

# Use the official ngrok image as the base
FROM ngrok/ngrok:latest

# The ngrok configuration file is typically stored in /home/ngrok/.ngrok2/
# We copy our local ngrok.yml file into that location inside the container.
COPY ngrok.yml /home/ngrok/.ngrok2/ngrok.yml

# This is the command that will be run when the container starts.
# It tells ngrok to start ALL tunnels defined in the configuration file.
# This is the key to solving the ERR_NGROK_108 error.
CMD ["start", "--all", "--config", "/home/ngrok/.ngrok2/ngrok.yml"]