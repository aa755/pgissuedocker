#!/bin/bash
cp coqtop-stale-proof-state coqtop
export PATH=`pwd`:$PATH
emacs demo-stale-proof.v

