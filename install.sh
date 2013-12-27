#!/usr/bin/env bash

# get path of this file
home="`dirname \`pwd\`'/'$BASH_SOURCE`"

# add bear bashrc to home bashrc
echo "add bash rc ..."
echo "source ${home}/conf/bashrc" >> ~/.bashrc

# add bear vimrc to home vimrc
echo "add vim rc ..."
echo "set runtimepath+=${home}/conf/vim" >> ~/.vimrc
echo "source ${home}/conf/vimrc" >> ~/.vimrc

# add git config to home gitconfig
echo "add git config ..."
echo "[include]" >> ~/.gitconfig
echo "    path = ${home}/conf/gitconfig" >> ~/.gitconfig

# update bashrc
echo "update bash rc ..."
source ~/.bashrc

echo "install finish"

