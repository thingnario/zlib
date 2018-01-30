#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./build_zlib.sh target_architecture!"
    echo "Example: ./build_zlib.sh arm-linux"
    exit
fi

export PATH="$PATH:$1/bin"

tool_chain_path=${1%/}

ARCH=`echo $tool_chain_path | awk -F"/" '{print (NF>1)? $NF : $tool_chain_path}'`
export CHOST="$ARCH"

./configure --prefix=`pwd`/final --static
make 
make install

cd final
cp -r * $tool_chain_path
