# Testing

To test the container before publication, run these steps.

1. `container_hash=$(podman build . -q)`.
2. `podman run --privileged --tty --interactive ${container_hash} bash`
