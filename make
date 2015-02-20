#!/bin/bash

set -x
set -e

jarball1=canarymod.jar
if [ ! -f $jarball1 ] ; then
  wget -cq http://canarymod.net/releases/latest-download -O $jarball1
fi

jarball2=scriptcraft.jar
if [ ! -f $jarball2 ] ; then
  wget -cq http://scriptcraftjs.org/download/latest/scriptcraft-3.1.2/$jarball2
fi

mkdir -p out
wconf=out/world.cfg
cp src/world.cfg $wconf
sed -i '/^world-type=/          s/=.*$/=FLAT/'  $wconf
sed -i '/^generate-structures=/ s/=.*$/=false/' $wconf
sed -i '/^spawn-.*=/            s/=.*$/=false/' $wconf
sed -i '/^game-mode=/           s/=.*$/=2/'     $wconf

docker build  .

