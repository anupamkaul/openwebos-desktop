#!/bin/sh

. ./common/envsetup.sh

NAME=$1
PROCCOUNT=$2

cd $WEBOS_DESKTOP_ROOT/$NAME
ls
cmake . -DCMAKE_INSTALL_PREFIX=$LUNA_STAGING -DCMAKE_BUILD_TYPE=RELEASE
make -j$PROCCOUNT
make install

cd $STARTDIR


