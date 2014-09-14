# Dockerfile for busybox+git using buildroot
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
                    python \
                    libc6-i386
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


# Add config
ADD             buildroot-config /tmp/builder/buildroot/.config

# Reformat config and prep for make            
RUN             make oldconfig

# Make
RUN             make --quiet

# Done!
RUN             cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar

# Remove duplicate binaries, perl, and python scripts in git-suite and other
# uneeded git files to bring down the image size. Reasoning and method
# described here:
# https://github.com/radial/core-busyboxplus/issues/2#issuecomment-42120299
RUN             mkdir /tmp/rootfs &&\
                tar -C /tmp/rootfs -pxf /tmp/rootfs.tar
WORKDIR         /tmp/rootfs/usr/libexec/git-core
RUN             rm -f \
                    git-add \
                    git-add--interactive \
                    git-annotate \
                    git-apply \
                    git-archimport \
                    git-archive \
                    git-bisect--helper \
                    git-blame \
                    git-branch \
                    git-bundle \
                    git-credential-cache \
                    git-credential-cache--daemon \
                    git-credential-store \
                    git-cat-file \
                    git-check-attr \
                    git-check-ignore \
                    git-check-mailmap \
                    git-check-ref-format \
                    git-checkout \
                    git-checkout-index \
                    git-cherry \
                    git-cherry-pick \
                    git-clean \
                    git-clone \
                    git-column \
                    git-commit \
                    git-commit-tree \
                    git-config \
                    git-count-objects \
                    git-credential \
                    git-cvsexportcommit \
                    git-cvsimport \
                    git-cvsserver \
                    git-daemon \
                    git-describe \
                    git-diff \
                    git-diff-files \
                    git-diff-index \
                    git-diff-tree \
                    git-difftool \
                    git-fast-export \
                    git-fast-import \
                    git-fetch \
                    git-fetch-pack \
                    git-fmt-merge-msg \
                    git-for-each-ref \
                    git-format-patch \
                    git-fsck \
                    git-fsck-objects \
                    git-gc \
                    git-get-tar-commit-id \
                    git-grep \
                    git-hash-object \
                    git-help \
                    git-http-backend\
                    git-imap-send \
                    git-index-pack \
                    git-init \
                    git-init-db \
                    git-log \
                    git-ls-files \
                    git-ls-remote \
                    git-ls-tree \
                    git-mailinfo \
                    git-mailsplit \
                    git-merge \
                    git-merge-base \
                    git-merge-file \
                    git-merge-index \
                    git-merge-ours \
                    git-merge-recursive \
                    git-merge-subtree \
                    git-merge-tree \
                    git-mktag \
                    git-mktree \
                    git-mv \
                    git-name-rev \
                    git-notes \
                    git-p4 \
                    git-pack-objects \
                    git-pack-redundant \
                    git-pack-refs \
                    git-patch-id \
                    git-peek-remote \
                    git-prune \
                    git-prune-packed \
                    git-push \
                    git-read-tree \
                    git-receive-pack \
                    git-reflog \
                    git-relink \
                    git-remote \
                    git-remote-ext \
                    git-remote-fd \
                    git-remote-testsvn \
                    git-repack \
                    git-replace \
                    git-repo-config \
                    git-rerere \
                    git-reset \
                    git-rev-list \
                    git-rev-parse \
                    git-revert \
                    git-rm \
                    git-send-email \
                    git-send-pack \
                    git-shell \
                    git-shortlog \
                    git-show \
                    git-show-branch \
                    git-show-index \
                    git-show-ref \
                    git-stage \
                    git-show-ref \
                    git-stage \
                    git-status \
                    git-stripspace \
                    git-svn \
                    git-symbolic-ref \
                    git-tag \
                    git-tar-tree \
                    git-unpack-file \
                    git-unpack-objects \
                    git-update-index \
                    git-update-ref \
                    git-update-server-info \
                    git-upload-archive \
                    git-var \
                    git-verify-pack \
                    git-verify-tag \
                    git-whatchanged \
                    git-write-tree

WORKDIR         /tmp/rootfs/usr/bin
RUN             rm -f \
                    git \
                    git-cvsserver \
                    git-shell \
                    git-receive-pack \
                    git-upload-pack \
                    git-upload-archive &&\
                ln -s ../libexec/git-core/git git &&\
                ln -s ../libexec/git-core/git-shell git-shell &&\
                ln -s ../libexec/git-core/git git-upload-archive &&\
                ln -s ../libexec/git-core/git-upload-pack git-upload-pack 

WORKDIR         /tmp/rootfs/usr/libexec/git-core
RUN             ln -s git git-merge

WORKDIR         /tmp/rootfs/usr/share
RUN             rm -rf \
                    gitweb \
                    locale

WORKDIR         /tmp/rootfs
RUN             tar -pcf ../rootfs.tar .

# Done!
WORKDIR         /tmp
RUN             md5sum rootfs.tar > rootfs.tar.md5
