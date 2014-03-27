# Dockerfile for busybox+git+curl using buildroot
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

# Configure buildroot for x86_64, curl and git
RUN         make defconfig
RUN         sed -i 's/BR2_i386=y/BR2_x86_64=y/' .config
RUN         sed -i 's/BR2_ARCH="i686"/BR2_ARCH="x86_64"/' .config
RUN         sed -i 's/BR2_GCC_TARGET_TUNE="i686"/BR2_GCC_TARGET_TUNE="generic"/' .config
RUN         sed -i 's/BR2_GCC_TARGET_ARCH="i686"/# BR2_GCC_TARGET_ARCH="i686"/' .config
RUN         sed -i 's/BR2_x86_i686=y/BR2_x86_generic=y/' .config
RUN         sed -i 's/BR2_UCLIBC_TARGET_ARCH="i386"/BR2_UCLIBC_TARGET_ARCH="x86_64"/' .config
RUN         sed -i 's/BR2_UCLIBC_X86_TYPE="686"/# BR2_UCLIBC_X86_TYPE="686"/' .config
RUN         echo BR2_ARCH_IS_64=y >>.config
RUN         echo BR2_LARGEFILE=y >>.config
RUN         echo BR2_PACKAGE_GIT=y >>.config
RUN         echo BR2_PACKAGE_ZLIB=y >>.config
RUN         echo BR2_PACKAGE_LIBCURL=y >>.config
RUN         echo BR2_PACKAGE_CURL=y >>.config
RUN         echo BR2_PACKAGE_LIBICONV=y >>.config
RUN         echo BR2_TOOLCHAIN_BUILDROOT_LARGEFILE=y >>.config
RUN         make olddefconfig

RUN         make --quiet

# Replace some symlinks in the image with empty files for Docker to bind-mount to
WORKDIR     /tmp/builder/buildroot/output/images
RUN         mkdir extra extra/etc extra/sbin
RUN         touch extra/etc/resolv.conf
RUN         touch extra/sbin/init
RUN         cp rootfs.tar rootfs-updated.tar
RUN         tar rvf rootfs-updated.tar -C extra .

# Done!
RUN         cp /tmp/builder/buildroot/output/images/rootfs-updated.tar /tmp/rootfs.tar
WORKDIR     /tmp
RUN         md5sum rootfs.tar > rootfs.tar.md5
