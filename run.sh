#!/bin/sh

[ "$1" ] || {
    echo "Specify which flavor of busybox to build:"
    ls -d */
    exit 1
    }
[ -d "$1" ] || {
    echo "Could not find directory $1."
        exit 1
    }

sudo docker build -t tarmaker $1/tarmaker || {
    echo "Something went wrong. Aborting."
        exit 1
    }

[ -f rootfs.tar ] && mv rootfs.tar rootfs.tar.old
[ -f rootfs.tar.md5 ] && mv rootfs.tar.md5 rootfs.tar.md5.old

sudo docker run --name builder tarmaker
sudo docker cp builder:/tmp/rootfs.tar $1
sudo docker cp builder:/tmp/rootfs.tar.md5 $1
cd $1
md5sum --check rootfs.tar.md5
sudo docker build -t brianclements/busyboxplus:$1 $1
