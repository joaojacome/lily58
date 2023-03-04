#!/bin/sh
DEST=qmk_firmware/keyboards/splitkb/aurora/lily58/keymaps/joaojacome
cp -r keymap/ $DEST


set -e
./qmk.sh compile -kb splitkb/aurora/lily58 -km joaojacome
