FROM debian:11

RUN apt update \
 && apt install curl -y --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
