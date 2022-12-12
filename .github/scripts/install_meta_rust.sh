#!/usr/bin/env bash

DIST_VERSION="${1}"
DIST_NAME="${DIST_VERSION}-meta"
DIST_TAR="rust-${DIST_NAME}.tar.gz"
DIST_URL="http://rust-dists.s3-website.us-west-1.amazonaws.com/dist/${DIST_TAR}"
RUSTUP_VERSION="meta-${DIST_VERSION}"
RUSTUP_DIR="${HOME}/.rustup/toolchains/${RUSTUP_VERSION}"

echo "[INFO] downloading ${DIST_NAME} dist from ${DIST_URL}"
wget -q -O /tmp/"${DIST_TAR}" "${DIST_URL}"

echo "[INFO] untarring ${DIST_TAR} at ${RUSTUP_DIR}"
mkdir -p "${RUSTUP_DIR}"
tar -C "${RUSTUP_DIR}" --strip-components 2 -xf /tmp/"${DIST_TAR}" rust-1.65.0-x86_64-unknown-linux-gnu/rustc/

echo "[INFO] fixing binaries under ${RUSTUP_DIR}"
find "${RUSTUP_DIR}"/bin/ -exec sh -c "file {} | grep 'dynamically linked' | cut -d':' -f1" \; | xargs -I {} patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 {}

echo "[INFO] installation finished with:"
cargo +"${RUSTUP_VERSION}" --version
rustc +"${RUSTUP_VERSION}" --version
