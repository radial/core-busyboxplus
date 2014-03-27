## Dockerfile for Busyboxplus

This repository creates a busybox image with a full chain from scratch using
[Buildroot](http://buildroot.uclibc.org).  It was compiled to make use of the
small size of Busybox with the additional following packages:

* Internet access
* Git (1.8.5.3)
* Curl (7.35.0)

My goal was to make a lightweight busybox-based volume-container that had the
ability to access other containers/servers/web-locations to grab and update
configuration. The possibilities are pretty extensive!

### Build

The included `run.sh` should do everything for you, but the steps are as
follows:

* in `/tarmaker`, the Dockerfile compiles the busybox image inside it's container.
* the resulting image is run so that we can
* use `docker cp` to move the rootfs.tar into this repository directory
* the tar is verified using and then imported

CAVEAT: At the moment, the script imports the final image in two different
ways because I think there is a docker bug in calculating the filesize of the
image. Feel free to edit that last part of the `run.sh` and pick one of the two
methods.

### Credits

Much thanks to [Jérôme Petazzoni](https://github.com/jpetazzo) for [this
excellent
post](http://blog.docker.io/2013/06/create-light-weight-docker-containers-buildroot)
and for inspiration from [his own](https://github.com/jpetazzo/docker-busybox)
busybox tarbuilder repository as well as [Paul
Nasrat](https://github.com/pnasrat) for pointing me in the right direction on 
the forums.
