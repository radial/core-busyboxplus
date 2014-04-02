## Dockerfile for Busyboxplus

This repository creates a busybox image with a full chain from scratch using
[Buildroot](http://buildroot.uclibc.org).  It was compiled to make use of the
small size of Busybox with the following additional items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6, bridge_utils, iproute2, iptables
    * OpenSSL (1.0.1f)
* Curl (7.35.0)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

My goal was to make a lightweight busybox-based volume-container that has the
ability to access other containers/servers/web-locations to grab and update
configuration. The possibilities are pretty extensive!

### Build

The included `run.sh` should do everything for you, but the steps are as
follows:

* in `/tarmaker`, the Dockerfile compiles the busybox image inside it's own
docker container,
* the resulting image is run so that we can
* use `docker cp` to move the rootfs.tar into this repository directory,
* then the tar is verified and imported

### Future Versions

* Add git back into the build (this was removed due to some serious bugs it
  introduced into the image)

### Credits

Much thanks to [Jérôme Petazzoni](https://github.com/jpetazzo) for [this
excellent
post](http://blog.docker.io/2013/06/create-light-weight-docker-containers-buildroot)
and for inspiration from [his own](https://github.com/jpetazzo/docker-busybox)
busybox tarbuilder repository as well as [Paul
Nasrat](https://github.com/pnasrat) for pointing me in the right direction on 
the forums.
