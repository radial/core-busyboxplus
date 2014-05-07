## Busyboxplus Base Image

This repository creates a busybox image with a full-chain from scratch using
[Buildroot](http://buildroot.uclibc.org). It is part of the
[Radial](https://github.com/radial) suite of images and tools and was compiled
to make use of the small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6

Other busyboxplus flavors include:

* [Busyboxplus-cURL][bbcurl]
* [Busyboxplus][bbplus]

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration for other containers that actually run the
application, or "Axle" containers. The configuration containers, or "Hub"
containers, have the ability to access other containers/servers/web-locations to
grab and update that configuration using these various cannonical tools. The
possibilities are pretty extensive!

[bbcurl]: https://index.docker.io/u/radial/busyboxplus-curl
[bbplus]: https://index.docker.io/u/radial/busyboxplus

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
