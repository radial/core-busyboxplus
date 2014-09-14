FROM            scratch
MAINTAINER      Brian Clements <radial@brianclements.net>
ADD             rootfs.tar /

# Setup and source bashrc for tab-complete, shell coloring
ADD             bashrc /root/.bashrc
ENV             HOME /root
ENV             ENV $HOME/.bashrc

CMD             ["/bin/sh"]
