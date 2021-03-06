#!/usr/bin/env bash

# get path of this file
home="`dirname \`pwd\`'/'$BASH_SOURCE`"

# add bear bashrc to home bashrc
echo "add bash rc ..."
echo "source ${home}/conf/bashrc" >> ~/.bash_profile

# add bear vimrc to home vimrc
echo "add vim rc ..."
echo "set runtimepath+=${home}/conf/vim" >> ~/.vimrc
echo "source ${home}/conf/vimrc" >> ~/.vimrc

# add git config to home gitconfig
echo "add git config ..."
git config --global include.path ${home}/conf/gitconfig

# update bashrc
echo "update bash rc ..."
source ~/.bashrc

echo "install finish"

