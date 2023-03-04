KEYBOARD := splitkb/aurora/lily58
KEYMAP := joaojacome

SRC := ./keymap
DEST := ./qmk_firmware/keyboards/$(KEYBOARD)/keymaps/$(KEYMAP)

QMK_CLI := nix develop --extra-experimental-features nix-command \
	--extra-experimental-features flakes --command \
	qmk

hello:
	echo "Hello, World"

.PHONY: clean
clean: keymap/*
	rm -rf $(DEST)
	cp -r $(SRC) $(DEST)

.PHONY: patch
patch:
	PATCH=$$(cat << EOF
		void keyboard_pre_init_user(void) {
		// Set our LED pin as output
		setPinOutput(24);
		// Turn the LED off
		// (Due to technical reasons, high is off and low is on)
		writePinHigh(24);
		}
	EOF
	)
	echo "$$PATCH" >> $(DEST)/keymap.c

.PHONY: flash
flash:
	$(QMK_CLI) flash -km $(KEYMAP) -kb $(KEYBOARD)
