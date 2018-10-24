#!/bin/bash
#source .bashrc

cd /turnkey/fab/products/$1

echo In products/$1
echo Current Build $2

export FAB_PATH=/turnkey/fab
export FAB_APT_PROXY=http://127.0.0.1:8124
export FAB_HTTP_PROXY=http://127.0.0.1:8124
export POOL_PATH=/turnkey/fab/pools/jessie

OLD=$(expr $2 - 1)

echo Old Build $OLD

CDPATH=.:/turnkey/fab:/turnkey:/turnkey/fab/products
export _CDPATH=$CDPATH

make clean
echo finished clean
make
echo finished build

#if [ ! -e "/tkl_builds/$1.$OLD.iso" ]; then
#       rm /tkl_builds/$1.$OLD.iso
#fi

rm /tkl_builds/$1.*
mv build/product.iso /tkl_builds/$1.$2.iso

if [[ $(date +%u) -eq 1 ]]; then
    echo Uploading to transfer.sh because it is Monday.
    TRANS=`curl --upload-file /tkl_builds/$1.$2.iso https://transfer.sh/$1.$2.iso
    echo $TRANS
    echo $TRANS > $3/$1.lastUploadUrl.md
fi

make clean

echo cleaned build directory

exit 0;