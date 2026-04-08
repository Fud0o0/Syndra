# Syndra Docker Profiles

Isolation profile per team. Each profile has its own Dockerfile.

## Available Dockerfiles

- `docker/Dockerfile.blue`
- `docker/Dockerfile.red`
- `docker/Dockerfile.purple`
- `docker/Dockerfile.root`

## Build

```bash
docker build -f docker/Dockerfile.blue -t syndra-blue .
docker build -f docker/Dockerfile.red -t syndra-red .
docker build -f docker/Dockerfile.purple -t syndra-purple .
docker build -f docker/Dockerfile.root -t syndra-root .
```

## Run

```bash
docker run --rm -it -v "$PWD":/workspace syndra-blue
docker run --rm -it -v "$PWD":/workspace syndra-red
docker run --rm -it -v "$PWD":/workspace syndra-purple
docker run --rm -it -v "$PWD":/workspace syndra-root
```

## Helper script

```bash
bash scripts/docker-profile.sh blue
bash scripts/docker-profile.sh red
bash scripts/docker-profile.sh purple
bash scripts/docker-profile.sh root
```

Build only:

```bash
bash scripts/docker-profile.sh purple --build-only
```

## Notes

- These containers are intended for isolated tool usage and testing.
- They do not replace a full Hyprland desktop installation on the host.
- For workstation setup, use the install scripts in this repository.
