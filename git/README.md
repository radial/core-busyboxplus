## Busyboxplus Images

This repository creates multiple flavors of busybox images with full-chains
from scratch using [Buildroot](http://buildroot.uclibc.org). It is part of the
[Radial](https://github.com/radial) suite of images and tools and was compiled
to make use of the small size of Busybox with some additional specialty items.

My goal was to make lightweight busybox-based volume-containers solely
for managing the configuration "Hub" containers and shared/bind-mounted volume
"Axle" containers for the container that actually runs the application, or
"Spoke" container. 

The Busyboxplus flavors are:

###Base Image

Available via `docker pull radial/busyboxplus:base`. 

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6

This image is the basis for the
[axle-base](https://index.docker.io/u/radial/axle-base/) image. At 1.27mb, it is
the smallest busybox build of all the flavors.

###cURL Image

Available via `docker pull radial/busyboxplus:curl`. In addition to the base
image, the cURL image adds:

* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f, includes
  ca-certificates), zlib (1.2.8), and Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

This image was created as an alternate for those only needing to use cURL to
extract their configuration in their [Hub containers][hub_cont]. This image, at
4.23mb, is a significant size savings over the following git image.

###Git Image

Available via `docker pull radial/busyboxplus:git`. In addition to the base and
cURL image (git requires cURL anyway for http/s support), the git image adds:

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

The git image is default [Hub container][hub_cont] image and weighs in at around
12.86mb. Hub containers have the ability to access other
containers/servers/web-locations to grab and update configuration using git
and/or cURL. The possibilities are pretty extensive!

[hub_cont]: https://index.docker.io/u/radial/hub-base/

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
