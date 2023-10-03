FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
 && apt install curl -y --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
