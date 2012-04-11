#!/bin/sh

STARTDIR=$PWD

while [ "$PWD" != "/" -a "$WEBOS_DESKTOP_ROOT" = "" ] ; do
   if [ -d ./openwebos-desktop ] ; then
      WEBOS_DESKTOP_ROOT=$PWD
   else
      cd ..
   fi
done

echo $WEBOS_DESKTOP_ROOT

export LUNA_STAGING=$WEBOS_DESKTOP_ROOT/staging
echo $LUNA_STAGING

export CJSON_INCLUDE_DIRS=$LUNA_STAGING/include
export CJSON_LIBRARIES=$LUNA_STAGING/lib

cd $STARTDIR

fail()
{
   cd $STARTDIR
   echo $1
   exit 1
}
