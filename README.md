

## Multi-arch support
- You maybe need to run this command to get buildx working properly, I do not know why.
```bash
docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
```
- You will need to set these variable before running build
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
