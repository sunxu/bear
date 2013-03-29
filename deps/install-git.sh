#!/usr/bin/env bash

# get path of this file
home="`dirname \`pwd\`'/'$BASH_SOURCE`"'/../'

# make temp path
tempath=`mktemp -d`

# change current dir to temp path
cd ${tempath}
echo "change to temp path: ${tempath}"

# download git source 
file="git-1.8.2.tar.gz"
echo "downloading vim source ..."
wget -t 3 https://git-core.googlecode.com/files/git-1.8.2.tar.gz
if [ ! -f $file ]; then
    echo "    fail"
    echo "download source file error"
    exit
fi
echo "downloading git source ...    succuss"

# check md5
echo -ne "checking source md5sum ..."
md5=`md5sum ${file} | awk -F" " '{print $1}'`
if [ "210834d73c857931c3da34a65eb3e597" != "$md5" ]; then
    echo "    fail"
    echo "check md5sum error"
    exit
fi
echo "    succuss"

# decompress git source
echo -ne "decompressing source   ..."
tar zxf ${file} 
cd git-1.8.2
echo "    succuss"

# make
echo -ne "making                 ..."
make prefix=${home}/deps/git > /dev/null 2>&1
if [ 0 != $? ]; then
    echo "    fail"
    echo "make error"
    exit
fi
echo "    succuss"

# make install
echo -ne "installing             ..."
make prefix=${home}/deps/git install > /dev/null 2>&1
echo "    succuss"

# clear
rm -rf ${tempath}

# add bin search path
echo "export PATH=${home}/deps/git/bin:\${PATH}" >> ~/.bashrc
source ~/.bashrc

echo "Installed the Git successfully! Enjoy :-)"

