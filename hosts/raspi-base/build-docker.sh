#!/usr/bin/env bash
set -xe

TIMSTAMP=$(date +%s)

docker compose build
docker tag ghcr.io/andreijiroh-dev/nixops-config/rpi-sd-imager:dev "ghcr.io/andreijiroh-dev/nixops-config/rpi-sd-imager:build-$TIMSTAMP"
docker push "ghcr.io/andreijiroh-dev/nixops-config/rpi-sd-imager:build-$TIMSTAMP"
