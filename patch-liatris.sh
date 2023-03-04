#!/bin/sh
set -e
DEST=qmk_firmware/keyboards/splitkb/aurora/lily58/keymaps/joaojacome
PATCH=$(cat << EOF

void keyboard_pre_init_user(void) {
  // Set our LED pin as output
  setPinOutput(24);
  // Turn the LED off
  // (Due to technical reasons, high is off and low is on)
  writePinHigh(24);
}

EOF
)

echo "$PATCH" >> $DEST/keymap.c
