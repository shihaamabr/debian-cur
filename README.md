

## Multi-arch support
- Install emulator:
```bash
docker run --privileged --rm tonistiigi/binfmt --uninstall qemu-* #Uninstall existing
docker run --privileged --rm tonistiigi/binfmt --install all
```

- You MAY also need to set these variable before running build, depending on the docker version on host
```bash
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
```
Enable (1) or disable (0) BuildKit builds

#### Building new container
- `cd` into a folder and run
```bash
docker compose build
```
