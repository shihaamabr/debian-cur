FROM debian:10

RUN apt update \
 && apt install curl -y --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
