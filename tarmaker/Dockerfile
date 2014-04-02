# Dockerfile for busybox+curl using buildroot
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

# Add the curl information
RUN         mkdir -p package/curl
WORKDIR     /tmp/builder/buildroot/package/curl
RUN         wget --no-check-certificate -nv https://gist.github.com/brianclements/9802627/raw/Config.in 
RUN         wget --no-check-certificate -nv https://gist.github.com/brianclements/9802627/raw/curl.mk
WORKDIR     /tmp/builder/buildroot

# Configure buildroot for x86_64, and curl
RUN         make defconfig
RUN         sed -i 's/BR2_i386=y/BR2_x86_64=y/' .config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_LARGEFILE=y >>.config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_INET_IPV6=y >>.config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_WCHAR=y >>.config
RUN         echo BR2_PACKAGE_BRIDGE_UTILS=y >>.config
RUN         echo BR2_PACKAGE_IPROUTE2=y >>.config
RUN         echo BR2_PACKAGE_IPTABLES=y >>.config
RUN         echo BR2_PACKAGE_LIBCURL=y >>.config
RUN         echo BR2_PACKAGE_CURL=y >>.config
RUN         echo BR2_PACKAGE_OPENSSL=y >>.config
RUN         echo BR2_PACKAGE_OPENSSL_BIN=y >>.config
RUN         echo BR2_PACKAGE_OPENSSL_ENGINES=y >>.config
RUN         echo BR2_package_OPENSSH=y >>.config
RUN         make olddefconfig

RUN         make --quiet

# Done!
RUN         cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar
WORKDIR     /tmp
RUN         md5sum rootfs.tar > rootfs.tar.md5
