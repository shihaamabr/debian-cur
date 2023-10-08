#!/bin/bash


docker compose build

docker tag debian-curl:x86-10 git.shihaam.dev/dockerfiles/debian-curl:x86-10
docker tag debian-curl:arm-10 git.shihaam.dev/dockerfiles/debian-curl:arm-10


docker push git.shihaam.dev/dockerfiles/debian-curl:x86-10
docker push git.shihaam.dev/dockerfiles/debian-curl:arm-10

docker manifest create git.shihaam.dev/dockerfiles/debian-curl:10 \
	git.shihaam.dev/dockerfiles/debian-curl:x86-10 \
	git.shihaam.dev/dockerfiles/debian-curl:arm-10

#docker manifest create git.shihaam.dev/dockerfiles/debian-curl/debian-curl:test \
#git.shihaam.dev/dockerfiles/debian-curl/debian-curl:test-git.shihaam.dev/dockerfiles/debian-curl/debian-curl:test-linux-amd64-v3 \
#git.shihaam.dev/dockerfiles/debian-curl/debian-curl:test-git.shihaam.dev/dockerfiles/debian-curl/debian-curl:test-linux-arm64

#docker manifest annotate git.shihaam.dev/dockerfiles/debian-curl:10 \
#git.shihaam.dev/dockerfiles/debian-curl:x86-10  --os linux --arch amd64

#docker manifest annotate git.shihaam.dev/dockerfiles/debian-curl:10 \
#git.shihaam.dev/dockerfiles/debian-curl:arm-10  --os linux --arch arm64


docker manifest push git.shihaam.dev/dockerfiles/debian-curl:10
