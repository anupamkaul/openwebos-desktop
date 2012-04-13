#!/bin/sh

. ./common/envsetup.sh

NAME=$1
PROCCOUNT=$2

cd $WEBOS_DESKTOP_ROOT/$NAME
sh autogen.sh
./configure --disable-static --prefix=$LUNA_STAGING
make -j$PROCCOUNT
make install

echo "STARTDIR IS $STARTDIR"
cd $STARTDIR

