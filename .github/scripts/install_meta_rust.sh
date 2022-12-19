#!/usr/bin/env bash

set -eu

DIST_VERSION="${1}"
DIST_NAME="${DIST_VERSION}-meta"
DIST_TAR="rust-${DIST_NAME}.tar.gz"
DIST_TAR_OUTPUT="/tmp/${DIST_TAR}"
DIST_URL="http://rust-dists.s3-website.us-west-1.amazonaws.com/dist/${DIST_TAR}"
RUSTUP_VERSION="meta-${DIST_VERSION}" # intentionally changing from VERSION-meta to meta-VERSION to make cargo play nice
RUSTUP_DIR="${HOME}/.rustup/toolchains/${RUSTUP_VERSION}"

cmd_exists() {
    if ! command -v "$1" > /dev/null 2>&1; then
        echo "[ERROR] command '$1' not found" >&2
        exit 1
    fi
}

cmd_exists curl
cmd_exists tar
cmd_exists rustup
cmd_exists rustc
cmd_exists cargo

echo "[INFO] downloading '${DIST_NAME}' dist from '${DIST_URL}'"
curl "${DIST_URL}" --silent --show-error --fail --output "${DIST_TAR_OUTPUT}"

echo "[INFO] untarring '${DIST_TAR}' at '${RUSTUP_DIR}'"
mkdir -p "${RUSTUP_DIR}"
rm -rf "${RUSTUP_DIR}"/*
tar -C "${RUSTUP_DIR}" --strip-components 2 -xf /tmp/"${DIST_TAR}" rust-"${DIST_VERSION}"-x86_64-unknown-linux-gnu/rustc/

echo "[INFO] installation for '${RUSTUP_VERSION}' finished with:"
cargo +"${RUSTUP_VERSION}" --version
rustc +"${RUSTUP_VERSION}" --version
