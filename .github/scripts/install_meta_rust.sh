#!/usr/bin/env bash

RUSTUP_DIST_SERVER=http://rust-dists.s3-website.us-west-1.amazonaws.com rustup toolchain install "$1"
find ~/.rustup/toolchains/"$1"/bin/ -exec sh -c "file {} | grep 'dynamically linked' | cut -d':' -f1" \; | xargs -I {} patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 {}
