## Busyboxplus cURL Image

This repository creates a cURL enabled busybox image with a full-chain from
scratch using [Buildroot](http://buildroot.uclibc.org). It is part of the
[Radial](https://github.com/radial) suite of images and tools and was compiled
to make use of the small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6
* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f, includes
  ca-certificates), zlib (1.2.8), and Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration "Hub" containers and shared/bind-mounted volume
"Axle" containers for the container that actually runs the application, or
"Spoke" container. 

Hub containers have the ability to access other containers/servers/web-locations
to grab and update configuration using git and/or cURL. The possibilities are
pretty extensive!

The default Hub container image is [busyboxplus][bbplus] which includes both
cURL and git. This image was created as an alternate for those only needing to
use cURL to extract their configuration in their Hub containers. This image, at
4.23mb, is a significant size savings over [busyboxplus][bbplus] which is
around 12.86mb.

Other busyboxplus flavors include:

* [Busybox][bb]
* [Busyboxplus][bbplus]

[bb]: https://index.docker.io/u/radial/busybox
[bbplus]: https://index.docker.io/u/radial/busyboxplus

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
