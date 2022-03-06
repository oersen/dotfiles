#!/bin/sh

build_dir="${XDG_DATA_HOME:-"$HOME/.local/share"}/lineageos"
image="docker.io/lineageos4microg/docker-lineage-cicd"

mkdir -p \
    "$build_dir/ccache" \
    "$build_dir/keys" \
    "$build_dir/local_manifests" \
    "$build_dir/logs" \
    "$build_dir/src" \
    "$build_dir/zips" \
    || exit

podman pull "$image" || exit

podman run \
    -it --privileged --rm \
    -e "BRANCH_NAME=cm-14.1" \
    -e "DEVICE_LIST=cancro" \
    -e "WITH_SU=true" \
    -v "$build_dir/ccache:/srv/ccache" \
    -v "$build_dir/keys:/srv/keys" \
    -v "$build_dir/local_manifests:/srv/local_manifests" \
    -v "$build_dir/logs:/srv/logs" \
    -v "$build_dir/src:/srv/src" \
    -v "$build_dir/zips:/srv/zips" \
    "$image"
