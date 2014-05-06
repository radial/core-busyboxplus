## Busyboxplus Base Image

This repository creates a busybox image with a full-chain from scratch using
[Buildroot](http://buildroot.uclibc.org).  It was compiled to make use of the
small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6

Other busyboxplus flavors include:

* [Busyboxplus-cURL][1]

[1]: https://index.docker.io/u/brianclements/busyboxplus-curl
More coming soon...

### Source

The tarbuilders used to create this image can be found [here][2]

[2]: https://github.com/brianclements/dockerfile-busyboxplus
