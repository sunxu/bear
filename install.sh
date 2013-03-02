#!/usr/bin/env bash

# get path of this file
file_path="`dirname \`pwd\`'/'$BASH_SOURCE`"

# add bear bashrc to home bashrc
echo "source ${file_path}/conf/bashrc" >> ~/.bashrc

# update bashrc
source ~/.bashrc
