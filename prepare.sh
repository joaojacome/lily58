#!/bin/sh

set -e
DEST=qmk_firmware/keyboards/splitkb/aurora/lily58/keymaps/joaojacome

./cleanup.sh

mv $DEST/keymap.json $DEST/_keymap.json
./qmk.sh json2c \
  $DEST/_keymap.json \
  -o $DEST/keymap.c
