#!/bin/sh
DEST=qmk_firmware/keyboards/splitkb/aurora/lily58/keymaps/joaojacome
rm -rf $DEST
cp -r keymap/ $DEST
