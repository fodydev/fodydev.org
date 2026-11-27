#!/bin/sh
# Local dev server (used by run-hugo-in-docker.sh). Hugo is installed from npm (see package.json).
set -e

npm install --no-audit --no-fund
npm run build:dev
npm run dev -- --logLevel info --bind 0.0.0.0
