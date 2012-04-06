#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
WEBOS_DESKTOP_PROJECT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $WEBOS_DESKTOP_PROJECT

. ./scripts/common/envsetup.sh

print_usage()
{
   echo options:
   echo "	-t [NAME] : Update only named target"
   echo "	-g [CMD]  : Command to pass to git, defaults to 'pull'"
}

GITCMD=pull
SRC="`/bin/ls -1 $WEBOS_DESKTOP_ROOT`"

while getopts t:g: ARG
do
   case "$ARG" in
   t) SRC=$OPTARG;;
   g) GITCMD=$OPTARG;;
   [?]) print_usage
        exit -1;;
   esac
done

for CURRENT in $SRC ; do
   GITREPO=$WEBOS_DESKTOP_ROOT/$CURRENT
   if [ -d $GITREPO/.git ] ; then
      echo ===========================
      echo "$CURRENT -> git $GITCMD"
      cd $GITREPO ; git $GITCMD
   fi
done

echo ===========================
echo Done
