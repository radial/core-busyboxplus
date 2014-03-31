#!/bin/sh

[ -f rootfs.tar ] && mv rootfs.tar rootfs.tar.old
[ -f rootfs.tar.md5 ] && mv rootfs.tar.md5 rootfs.tar.md5.old

sudo docker build -t tarmaker ./tarmaker
sudo docker run --name builder tarmaker
sudo docker cp builder:/tmp/rootfs.tar .
sudo docker cp builder:/tmp/rootfs.tar.md5 .
md5sum --check rootfs.tar.md5
sudo docker build -t brianclements/busyboxplus .
