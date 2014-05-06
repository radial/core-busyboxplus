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

Other busyboxplus flavors include:

* [Busyboxplus][bb]
* [Busyboxplus-git][bbgit]

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration for other containers that actually run the
application, or "Axle" containers. The configuration containers, or "Hub"
containers, have the ability to access other containers/servers/web-locations to
grab and update that configuration using these various cannonical tools. The
possibilities are pretty extensive!

[bb]: https://index.docker.io/u/radial/busyboxplus
[bbgit]: https://index.docker.io/u/radial/busyboxplus-git

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
