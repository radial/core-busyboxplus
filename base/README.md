## Busyboxplus Base Image

This repository creates a busybox image with a full-chain from scratch using
[Buildroot](http://buildroot.uclibc.org).  It was compiled to make use of the
small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6, bridge_utils, iproute2, iptables

Other busyboxplus flavors include:
* Busyboxplus-cURL

More coming soon...

### Source

The tarbuilders used to create this image can be found [here][1]

[1]: https://github.com/brianclements/dockerfile-busyboxplus
