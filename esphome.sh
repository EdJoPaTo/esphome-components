#!/usr/bin/env bash
set -eux

nice podman run --rm -it \
	-v "${PWD}":/config \
	docker.io/esphome/esphome \
	"$@"
