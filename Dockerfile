FROM n8nio/n8n:latest
USER root
RUN apt-get update \
  && apt-get install -y ffmpeg \
  && npm install --prefix /usr/local/lib/node_modules/n8n n8n-nodes-ffmpeg \
  && rm -rf /var/lib/apt/lists/*
USER node
