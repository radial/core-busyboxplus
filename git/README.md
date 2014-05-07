## Busyboxplus Git Image

This repository creates a git and cURL enabled busybox image with a full-chain
from scratch using [Buildroot](http://buildroot.uclibc.org). It is part of the
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
    * Git requires cURL anyway for http/s support, so included the full build of
      it.
* Git (1.8.3.5)
    * built with OpenSSL (1.0.1f, includes ca-certificates) and zlib (1.2.8) 
    * Protocols: local, git, http, https, (no SSH)
        * This build is made for importing repositories securely, so the above
          protocols will work for `git clone` and `git fetch` for example but
          will be lacking if you attempt a standard workflow (cannot push new
          commits securly to remote server).
    * This is a bare minimum package made to support all the core git functions
      as found in `git --help`.  All other tools and extras found in the git
      suite have been stripped to keep the image size to a minimum. Additional
      git features such as the server backends, cvs and shell login, svn
      support, and some others can be easily added back in at a cost of about
      0.5 - 1mb of image size per item. Feel free to reach out with requests for
      custom git builds.

Other busyboxplus flavors include:

* [Busybox][bb]
* [Busyboxplus-curl][bbcurl]

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration for other containers that actually run the
application, or "Axle" containers. The configuration containers, or "Hub"
containers, have the ability to access other containers/servers/web-locations to
grab and update that configuration using these various cannonical tools. The
possibilities are pretty extensive!

[bb]: https://index.docker.io/u/radial/busybox
[bbcurl]: https://index.docker.io/u/radial/busyboxplus-curl

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
