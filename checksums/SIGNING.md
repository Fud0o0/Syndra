# Signing and Checksum Policy

This repository ships a checksum manifest in `checksums/sha256sums.txt`.

## Verify locally

```bash
bash scripts/verify-artifacts.sh
```

To require signature validation:

```bash
SYNDRA_REQUIRE_SIGNATURE=1 bash scripts/verify-artifacts.sh
```

## Release signing process (maintainers)

1. Regenerate checksums:
```bash
cd /path/to/SyndraShell
sha256sum \
  install.sh \
  scripts/secure-install.sh \
  scripts/verify-artifacts.sh \
  scripts/container-tools.sh \
  scripts/install-syndra-base.sh \
  scripts/install-blue.sh \
  scripts/install-red.sh \
  scripts/install-purple.sh \
  scripts/install-root.sh \
  docs/get/blue.sh \
  docs/get/red.sh \
  docs/get/purple.sh \
  docs/get/root.sh \
  docker/Dockerfile.blue \
  docker/Dockerfile.red \
  docker/Dockerfile.purple \
  docker/Dockerfile.root \
  > checksums/sha256sums.txt
```

2. Sign the manifest:
```bash
gpg --armor --detach-sign --output checksums/sha256sums.txt.asc checksums/sha256sums.txt
```

3. Publish both files in release artifacts.
