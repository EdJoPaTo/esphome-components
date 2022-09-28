#!/usr/bin/env bash
set -eux

podman run --rm -it \
	-v "${PWD}":/config \
	docker.io/esphome/esphome \
	"$@"
