#!/usr/bin/env bash

# get path of this file
home="`dirname \`pwd\`'/'$BASH_SOURCE`"'/../'

# make temp path
tempath=`mktemp -d`

# change current dir to temp path
cd ${tempath}
echo "change to temp path: ${tempath}"

# download vim source 
file="vim-7.3.tar.bz2"
echo "downloading vim source ..."
wget -t 3 http://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
if [ ! -f $file ]; then
    wget -t 3 http://vim.mirror.fr/unix/vim-7.3.tar.bz2
fi
if [ ! -f $file ]; then
    echo "    fail"
    echo "download source file error"
    exit
fi
echo "downloading vim source ...    succuss"

# check md5
echo -ne "checking source md5sum ..."
md5=`md5sum ${file} | awk -F" " '{print $1}'`
if [ "5b9510a17074e2b37d8bb38ae09edbf2" != "$md5" ]; then
    echo "    fail"
    echo "check md5sum error"
    exit
fi
echo "    succuss"

# decompress vim source
echo -ne "decompressing source   ..."
tar jxf ${file} 
cd vim73
echo "    succuss"

# configure
echo -ne "configuring            ..."
./configure --disable-darwin --enable-perlinterp --enable-tclinterp      \
        --enable-pythoninterp --enable-python3interp --enable-rubyinterp \
        --without-x --disable-gui --without-x --with-features=huge       \
        --enable-cscope --prefix=${home}/deps/vim > /dev/null 2>&1
if [ 0 != $? ]; then
    echo "    fail"
    echo "configure error"
    exit
fi
echo "    succuss"

# make
echo -ne "making                 ..."
make > /dev/null 2>&1
if [ 0 != $? ]; then
    echo "    fail"
    echo "make error"
    exit
fi
echo "    succuss"

# make install
echo -ne "installing             ..."
make install > /dev/null 2>&1
echo "    succuss"

# clear
#rm -rf ${tempath}

# add bin search path
echo "export PATH=${home}/deps/vim/bin:\${PATH}" >> ~/.bashrc
source ~/.bashrc

echo "Installed the Vim successfully! Enjoy :-)"

