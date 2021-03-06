#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
WEBOS_DESKTOP_PROJECT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $WEBOS_DESKTOP_PROJECT

. ./scripts/common/envsetup.sh

SRC="
pmloglib
cjson
luna-service2
db8
"

DEVELOPER=false
PROCCOUNT=$(grep -c processor /proc/cpuinfo)

build_usage()
{
   echo options:
   echo "	-d : enables developer mode. Code is checked out from github with read and write permissions"
   echo "	-j [Integer] : Enables multiprocess builds. Similar to make -j command"
   echo "	-t [NAME] : Builds only named target"
}

while getopts dj:t: ARG
do
   case "$ARG" in
   d) DEVELOPER=true;;
   j) PROCCOUNT=$OPTARG;;
   t) SRC=$OPTARG;;
   [?]) build_usage
        exit -1;;
   esac
done

for CURRENT in $SRC ; do
   if [ ! -d ../$CURRENT ] ; then
      if [ $DEVELOPER = "true" ] ; then
         git clone git@github.com:anupamkaul/$CURRENT.git ../$CURRENT
      else
         git clone https://github.com/anupamkaul/$CURRENT.git ../$CURRENT
      fi
      [ "$?" == "0" ] || fail "Failed to checkout: $CURRENT"
   else
      echo found ../$CURRENT
   fi
done

cd ./scripts

for CURRENT in $SRC ; do
   if [ -x ./build_$CURRENT.sh ] ; then
      echo building $CURRENT
      ./build_$CURRENT.sh $CURRENT $PROCCOUNT
      [ "$?" == "0" ] || fail "Failed to build: $CURRENT"
   else
      echo No build script for $CURRENT
   fi
done
cd ..
echo ""
echo "============================================"
echo "webos desktop build completed"
echo "============================================"
echo ""
