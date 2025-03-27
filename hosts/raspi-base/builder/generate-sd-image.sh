#!/bin/sh

set -e

/root/.nix-profile/bin/nixos-generate \
  --format sd-aarch64-installer \
  --system aarch64-linux \
  --configuration /build/src/sd-image.nix \
    | tee /build/src/nixos-generate-output.txt

ARTIFACT="$(tail -1 /build/src/nixos-generate-output.txt)"

if echo $ARTIFACT | grep -q -E 'system$'
then
  ARTIFACT="$(dirname $ARTIFACT)/hydra-build-products"
fi

if echo $ARTIFACT | grep -q -E 'hydra-build-products$'
then
  IMG="$(head -1 $ARTIFACT | awk '{ print $3 }')"
else
  IMG=$ARTIFACT
fi

echo "Found img file: $IMG"

mkdir -pv /build/out || true
cp -v $IMG /build/out/