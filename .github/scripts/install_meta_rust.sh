#!/usr/bin/env bash

DIST_VERSION="${1}"
DIST_NAME="${DIST_VERSION}-meta"
DIST_TAR="rust-${DIST_NAME}.tar.gz"
DIST_URL="http://rust-dists.s3-website.us-west-1.amazonaws.com/dist/${DIST_TAR}"
RUSTUP_VERSION="meta-${DIST_VERSION}" # intentionally changing from VERSION-meta to meta-VERSION to make cargo play nice
RUSTUP_DIR="${HOME}/.rustup/toolchains/${RUSTUP_VERSION}"

echo "[INFO] downloading ${DIST_NAME} dist from ${DIST_URL}"
wget -q -O /tmp/"${DIST_TAR}" "${DIST_URL}"

echo "[INFO] untarring ${DIST_TAR} at ${RUSTUP_DIR}"
mkdir -p "${RUSTUP_DIR}"
tar -C "${RUSTUP_DIR}" --strip-components 2 -xvf /tmp/"${DIST_TAR}" rust-"${DIST_VERSION}"-x86_64-unknown-linux-gnu/rustc/

echo "[INFO] installation for ${RUSTUP_VERSION} finished with:"
cargo +"${RUSTUP_VERSION}" --version
rustc +"${RUSTUP_VERSION}" --version
