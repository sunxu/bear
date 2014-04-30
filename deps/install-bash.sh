#!/usr/bin/env bash

# get path of this file
home="`dirname \`pwd\`'/'$BASH_SOURCE`"'/../'

# make temp path
tempath=`mktemp -d`

# change current dir to temp path
cd ${tempath}
echo "change to temp path: ${tempath}"

# download vim source 
file="bash-4.1.tar.gz"
echo "downloading vim source ..."
wget -t 3 http://ftp.gnu.org/gnu/bash/bash-4.1.tar.gz 
if [ ! -f $file ]; then
    wget -t 3 http://ftp.gnu.org/gnu/bash/bash-4.1.tar.gz
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
if [ "9800d8724815fd84994d9be65ab5e7b8" != "$md5" ]; then
    echo "    fail"
    echo "check md5sum error"
    exit
fi
echo "    succuss"

# decompress vim source
echo -ne "decompressing source   ..."
tar zxf ${file} 
cd bash-4.1 
echo "    succuss"

# configure
echo -ne "configuring            ..."
./configure --prefix=${home}/deps/bash > /dev/null 2>&1
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
rm -rf ${tempath}

# add bin search path
echo "export PATH=${home}/deps/bash/bin:\${PATH}" >> ~/.bashrc
source ~/.bashrc

echo "Installed the Bash successfully! Enjoy :-)"

