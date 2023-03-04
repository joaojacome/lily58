mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

KEYBOARD := splitkb/aurora/lily58
KEYMAP := joaojacome

BUILD_DIR := $(mkfile_dir)/build
SRC := $(mkfile_dir)/keymap
SRC_FILES := $(wildcard $(SRC)/*)
DEST := $(mkfile_dir)/qmk_firmware/keyboards/$(KEYBOARD)/keymaps/$(KEYMAP)
DEST_FILES := $(DEST)/rules.mk $(DEST)/keymap.c
FIRWMARE_FILE := splitkb_aurora_lily58_rev1_joaojacome_promicro_rp2040.uf2

QMK_CLI := nix develop --extra-experimental-features nix-command \
	--extra-experimental-features flakes --command \
	qmk

.PHONY: clean-build clean-keymap flash compile clone

flash: qmk_firmware $(BUILD_DIR)/$(FIRWMARE_FILE)
	$(QMK_CLI) flash -e BUILD_DIR=$(BUILD_DIR) -km $(KEYMAP) -kb $(KEYBOARD)

clean-build:
	rm -rf $(BUILD_DIR)

clean-keymap:
	rm -rf $(DEST)

compile: qmk_firmware $(DEST_FILES) $(DEST)/keymap.c 
	$(MAKE) $(BUILD_DIR)/$(FIRWMARE_FILE)

clone: qmk_firmware


$(BUILD_DIR)/$(FIRWMARE_FILE): $(SRC_FILES) $(DEST_FILES) $(DEST)/keymap.c
	mkdir -p $(BUILD_DIR)
	$(QMK_CLI) compile -e BUILD_DIR=$(BUILD_DIR) -km $(KEYMAP) -kb $(KEYBOARD)

$(DEST)/keymap.c: $(SRC)/keymap.json $(DEST)/liatris.c
	$(QMK_CLI) json2c $(SRC)/keymap.json -o $(DEST)/keymap.c
	cat $(DEST)/liatris.c >> $(DEST)/keymap.c

$(DEST)/%: $(SRC)/%
	mkdir -p $(DEST)
	cp $? $@

qmk_firmware:
	$(QMK_CLI) clone
