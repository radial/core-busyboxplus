# Dockerfile for busybox+curl using buildroot
FROM            radial/distro:us-west-1
MAINTAINER      Brian Clements <radial@brianclements.net>

# Install packages
ENV             DEBIAN_FRONTEND noninteractive
RUN             apt-get -q update && apt-get -qyV install \
                    wget \
                    build-essential \
                    libncurses-dev \
                    rsync \
                    unzip \
                    bc \
                    gnupg \
                    python
RUN             env --unset=DEBIAN_FRONTEND

# Create directories
RUN             mkdir -p /tmp/builder
WORKDIR         /tmp/builder

# Retrieve files and check authenticity
ENV             BR_VERSION 2014.02
RUN             wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz &&\
                wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz.sign &&\
                wget -nv http://uclibc.org/~jacmet/pubkey.gpg &&\
                gpg --import pubkey.gpg &&\
                gpg --verify buildroot-$BR_VERSION.tar.gz.sign

# Extract
RUN             tar -zxf buildroot-$BR_VERSION.tar.gz &&\
                mv buildroot-$BR_VERSION buildroot
WORKDIR         /tmp/builder/buildroot

# Add the curl information
RUN             mkdir -p package/curl
WORKDIR         /tmp/builder/buildroot/package/curl
RUN             wget --no-check-certificate -nv https://gist.github.com/brianclements/9802627/raw/Config.in &&\
                wget --no-check-certificate -nv https://gist.github.com/brianclements/9802627/raw/curl.mk
WORKDIR         /tmp/builder/buildroot

# Configure base buildroot image
RUN             make defconfig

# Add base config
RUN             sed -i 's/BR2_i386=y/BR2_x86_64=y/' .config &&\
                echo BR2_TOOLCHAIN_BUILDROOT_LARGEFILE=y >>.config &&\
                echo BR2_TOOLCHAIN_BUILDROOT_INET_IPV6=y >>.config &&\
                echo BR2_TOOLCHAIN_BUILDROOT_WCHAR=y >>.config

# Add image flavor
RUN             echo BR2_PACKAGE_LIBCURL=y >>.config &&\
                echo BR2_PACKAGE_CURL=y >>.config &&\
                echo BR2_PACKAGE_OPENSSL=y >>.config &&\
                echo BR2_PACKAGE_LIBSSH2=y >>.config &&\
                echo BR2_PACKAGE_CA_CERTIFICATES=y >>.config

# Reformat config and prep for make            
RUN             make oldconfig

# Make
RUN             make --quiet

# Done!
RUN             cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar
WORKDIR         /tmp
RUN             md5sum rootfs.tar > rootfs.tar.md5
