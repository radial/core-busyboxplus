## Dockerfile for Busyboxplus

This repository creates a busybox image with a full chain from scratch using
[Buildroot](http://buildroot.uclibc.org).  It was compiled to make use of the
small size of Busybox with the following additional items for a "base" image:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6, bridge_utils, iproute2, iptables

In addition to the above, this repository can build the following "curl" flavor
of Busybox:
* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f), zlib (1.2.8), and
  Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

My goal was to make a lightweight busybox-based volume-containers that have the
ability to access other containers/servers/web-locations to grab and update
configuration using these various cannonical tools. The possibilities are pretty
extensive!

### Build

The included `run.sh` should do everything for you, but the steps are as
follows:

* `sudo -i` so you don't have to babysit your sudo password timeout throughout
  all the steps.
* run script and select your flavor build: `./run.sh curl`
* the script selects the `/tarmaker` of your choice and the Dockerfile compiles
  the busybox image inside it's own docker container,
* the resulting image is run so that we can
* use `docker cp` to move the rootfs.tar into the flavor directory,
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
