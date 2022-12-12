#!/usr/bin/env bash

# RUSTUP_DIST_SERVER=http://rust-dists.s3-website.us-west-1.amazonaws.com rustup toolchain install "$1"
DIST_VERSION="${1}"
DIST_NAME="${DIST_VERSION}-meta"
DIST_TAR="rust-${DIST_NAME}.tar.gz"
RUSTUP_VERSION="meta-${DIST_VERSION}"

wget -q -O /tmp/"${DIST_TAR}" http://rust-dists.s3-website.us-west-1.amazonaws.com/dist/"${DIST_TAR}"
mkdir -p ~/.rustup/toolchains/"${RUSTUP_VERSION}"
tar -C ~/.rustup/toolchains/"${RUSTUP_VERSION}"/ --strip-components 2 -xvf /tmp/"${DIST_TAR}" rust-1.65.0-x86_64-unknown-linux-gnu/rustc/
find ~/.rustup/toolchains/"${RUSTUP_VERSION}"/bin/ -exec sh -c "file {} | grep 'dynamically linked' | cut -d':' -f1" \; | xargs -I {} patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 {}
rustup default "${RUSTUP_VERSION}"

rustup default
rustc --version
cargo --version
