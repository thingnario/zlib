#!/bin/bash
set -x

if [ "$#" -ne 1 ]; then
    echo "Usage: ./build_zlib.sh target_architecture!"
    echo "Example: ./build_zlib.sh arm-linux"
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

make distclean
./configure --prefix=$tool_chain_path --static
make 
sudo make install
