#!/bin/bash
set -x

if [ "$#" -ne 2 ]; then
    echo "Usage: ./build_zlib.sh tool_chain_path install_path!"
    echo "Example: ./build_zlib.sh /usr/local/arm-linux /Desktop/eric/logger/build/moxa-ia240/zlib"
    exit
fi

export PATH="$PATH:$1/bin"

tool_chain_path=${1%/}

# linux architecture
item=`ls $tool_chain_path/bin | grep gcc`
IFS=' ' read -ra ADDR <<< "$item"
item="${ADDR[0]}"
ARCH=`echo $item | sed -e 's/-gcc.*//g'`

export CHOST="$ARCH"
export CFLAGS="-fPIC"

make clean
make distclean
./configure --prefix=$2 --static
make 
make install
