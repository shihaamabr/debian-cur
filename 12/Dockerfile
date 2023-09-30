FROM debian:12

RUN apt update \
 && apt install curl -y --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
