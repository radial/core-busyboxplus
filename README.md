## Dockerfiles for Busyboxplus Builders

This repository creates busybox images with full-chains from scratch using
[Buildroot](http://buildroot.uclibc.org). They are part of the
[Radial](https://github.com/radial) suite of images and tools and were compiled
to make use of the small size of Busybox, but still be very featureful. 

The **Base** image includes:

* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6

In addition to the above, this repository can build the following additional
flavors:

**cURL**

* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f, includes
  ca-certificates), zlib (1.2.8), and Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP

**Git**

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
      suite have been stripped out to keep the image size to a minimum.
      Additional git features such as the server backends, cvs and shell login,
      svn support, and some others can be easily added back in at a cost of
      about 0.5 - 1mb of image size per item. Feel free to reach out with
      requests for custom git builds if it suites your workflow.

My goal was to make lightweight busybox-based volume-containers solely for
managing the configuration for other containers that actually run the
application, or "Axle" containers. The configuration containers, or "Hub"
containers, have the ability to access other containers/servers/web-locations to
grab and update that configuration using these various cannonical tools. The
possibilities are pretty extensive!

### Build

The included `run.sh` should do everything for you, but the steps are as
follows:

* `sudo -i` so you don't have to babysit your sudo password timeout throughout
  all the steps (building can take ~30-60 minutes depending on which flavor).
* run script and select your flavor build: `./run.sh curl`
* the script selects the `/tarmaker` of your choice and the Dockerfile compiles
  the busybox image inside it's own docker container,
* the resulting image is run so that we can
* use `docker cp` to move the rootfs.tar into the flavor directory,
* then the tar is verified and imported

### Future Flavor Additions

* SSH server/client. Possibly for stand-alone purposes, and possibly as a
  feature for remote git management.

### Credits

Much thanks to:

* [Jérôme Petazzoni](https://github.com/jpetazzo) for [this excellent post](http://blog.docker.io/2013/06/create-light-weight-docker-containers-buildroot)
  and for inspiration from [his own](https://github.com/jpetazzo/docker-busybox)
  busybox tarbuilder repository.
* [Paul Nasrat](https://github.com/pnasrat) for pointing me in the right
  direction on the forums.
* [Thomas De Schampheleire](http://buildroot-busybox.2317881.n4.nabble.com/template/NamlServlet.jtp?macro=user_nodes&user=1119)
  from the buildroot lists for helping me sort out the git bugs.
