#!/bin/bash
cp coqtop-hang coqtop
export PATH=`pwd`:$PATH
emacs demo-hang.v
