#!/bin/sh

set -e

./prepare.sh
./patch-liatris.sh
./compile.sh


#git clone --recurse-submodules https://github.com/qmk/qmk_firmware.git --depth 1 --shallow-submodules || true
#mkdir -p ./qmk_firmware/keyboards/splitkb/aurora/lily58/keymaps/joaojacome
