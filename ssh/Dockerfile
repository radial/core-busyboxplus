FROM        scratch
MAINTAINER  Brian Clements <brian@brianclements.net>
ADD         rootfs.tar /

# TODO: revisit keygen/storage/password/sshd-config logic. This is unfinished
CMD         ssh-keygen &&\
            /usr/sbin/sshd -D
