# Dockerfile for busybox using buildroot
FROM        brianclements/ubuntu
MAINTAINER  Brian Clements <brian@brianclements.net>

# Update and create temp directories
ENV DEBIAN_FRONTEND noninteractive
RUN         apt-get -q update
RUN         apt-get -qy install wget build-essential libncurses-dev rsync unzip bc gnupg python
RUN         mkdir -p /tmp/builder
RUN         env --unset=DEBIAN_FRONTEND
WORKDIR     /tmp/builder

# Retrieve files and check authenticity
ENV BR_VERSION 2014.02
RUN         wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz
RUN         wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz.sign
RUN         wget -nv http://uclibc.org/~jacmet/pubkey.gpg
RUN         gpg --import pubkey.gpg
RUN         gpg --verify buildroot-$BR_VERSION.tar.gz.sign

# Extract
RUN         tar -zxf buildroot-$BR_VERSION.tar.gz
RUN         mv buildroot-$BR_VERSION buildroot
WORKDIR     /tmp/builder/buildroot

# Configure base buildroot image
RUN         make defconfig
RUN         sed -i 's/BR2_i386=y/BR2_x86_64=y/' .config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_LARGEFILE=y >>.config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_INET_IPV6=y >>.config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_WCHAR=y >>.config
RUN         echo BR2_PACKAGE_BRIDGE_UTILS=y >>.config
RUN         echo BR2_PACKAGE_IPROUTE2=y >>.config
RUN         echo BR2_PACKAGE_IPTABLES=y >>.config
RUN         make oldconfig

RUN         make --quiet

# Done!
RUN         cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar
WORKDIR     /tmp
RUN         md5sum rootfs.tar > rootfs.tar.md5
