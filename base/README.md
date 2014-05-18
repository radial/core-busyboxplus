## Busyboxplus Base Image

This repository creates a busybox image with a full-chain from scratch using
[Buildroot](http://buildroot.uclibc.org). It is part of the
[Radial](https://github.com/radial) suite of images and tools and was compiled
to make use of the small size of Busybox with the following items:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration "Hub" containers and shared/bind-mounted volume
"Axle" containers for the container that actually runs the application, or
"Spoke" container. 

This image is the basis for the "Axle" container. At 1.27mb, it is the smallest
busybox build of all the flavors.

Other busyboxplus flavors include:

* [Busyboxplus-curl][bbcurl]
* [Busyboxplus][bbplus]

[bbcurl]: https://index.docker.io/u/radial/busyboxplus-curl
[bbplus]: https://index.docker.io/u/radial/busyboxplus

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/radial/core-busyboxplus
