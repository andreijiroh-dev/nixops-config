# Adopted from https://github.com/dfrankland/nixos-rpi-sd-image/blob/f0ad101a1d555e2310d4e238d55b7f068e2f6951/nixos-rpi-sd-image/Dockerfile,
# but updated the commit hash for nixos-generators
FROM multiarch/qemu-user-static:x86_64-aarch64 as qemu

FROM nixos/nix as nixos

COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin

RUN \
  set -e; \
  echo 'extra-platforms = aarch64-linux' >> /etc/nix/nix.conf; \
  nix-env -f https://github.com/nix-community/nixos-generators/archive/42ee229088490e3777ed7d1162cb9e9d8c3dbb11.tar.gz -i;

COPY ./builder/generate-sd-image.sh /
COPY . /build/src/

WORKDIR /build/src
CMD ["/generate-sd-image.sh"]