#!/bin/sh

set -e

nix develop --extra-experimental-features nix-command \
  --extra-experimental-features flakes --command \
  qmk $@
