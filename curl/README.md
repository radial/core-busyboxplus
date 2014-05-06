## Busyboxplus cURL Image

This repository creates a cURL enabled busybox image with a full-chain from
scratch using [Buildroot](http://buildroot.uclibc.org).  It was compiled to make
use of the small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6
* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f), zlib (1.2.8), and
  Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

My goal was to make lightweight busybox-based volume-containers that have the
ability to access other containers/servers/web-locations to grab and update
configuration using these various cannonical tools. The possibilities are pretty
extensive!

Other busyboxplus flavors include:

* [Busyboxplus][1]

More coming soon...

[1]: https://index.docker.io/u/brianclements/busyboxplus
### Source

The tarbuilders used to create this image can be found [here][2]

[2]: https://github.com/brianclements/dockerfile-busyboxplus
