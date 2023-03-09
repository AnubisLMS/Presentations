#!/bin/bash

set -e

linuxkit build -format iso-efi linuxkit-docker.yml
linuxkit run vbox --iso --uefi linuxkit-docker-efi.iso
