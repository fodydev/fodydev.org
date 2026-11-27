#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run as the host user so generated files are owned by you.
# With rootless Docker, container root already maps to the host user.
if docker info -f '{{.SecurityOptions}}' 2>/dev/null | grep -q rootless; then
  USER_ARGS="--user 0:0"
else
  USER_ARGS="--user $(id -u):$(id -g)"
fi

# Node.js image; Hugo, Dart Sass and Pagefind come from npm (see package.json).
# node_modules is a tmpfs so the host's packages never mix with the container's.
docker run -it --rm --name fodydev-hugo \
  ${USER_ARGS} \
  -v "${DIR}":/project \
  --tmpfs /project/node_modules:exec,mode=1777 \
  -w /project \
  -e HOME=/tmp \
  -e HUGO_CACHEDIR=/tmp/hugo_cache \
  -p 1313:1313 \
  node:22-bookworm-slim \
  sh /project/run-hugo.sh
