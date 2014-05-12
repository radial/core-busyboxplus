FROM            scratch
MAINTAINER      Brian Clements <radial@brianclements.net>
ADD             rootfs.tar /

# Can't `git pull` unless we set these
RUN             git config --global user.email "radial@brianclements.net" &&\
                git config --global user.name "radial"

CMD             ["/bin/sh"]
