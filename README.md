

## Multi-arch support
- You maybe need to run this command to get buildx if you get this error

**Error:**
```
exec /bin/sh: exec format error
```
**Fixing command:**
```bash
docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
```
i have no idea what it does, but it seems to fix the thing ._.

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
