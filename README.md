# Scripts to build Dell Repository Manager Container Image

Firmware updates are always a pain, but Dell has some tools to make it
a bit less painful. With the Dell Repository Manager it is possible to
make an internal mirror of the Dell Firmware repositories and then use
the Dell iDRAC to stage the firmware updates to be installed on the
next reboot.

Unfortunately there are a few limitations. The DRM application only
installs on CentOS and is hard coded to bind to localhost. I couldn't
find an easy way around either of these problems, but docker makes it
fairly easy. With a centos:7 base image, the drm app can now run on
any Linux host that runs Docker. I also use socat to bypass the
localhost binding restriction.

# Running the image

A place to store all the firmware images is required. To make the app
available to all, redirect port 8090 to the socat port:

    docker run --name drm -d --tmpfs /tmp -v <local disk path>:/var/dell/drm/ \
      -p 8090:8091 <registry>/drm:3.2

To bind to localhost, bind directly to the app port:

    docker run --name drm -d --tmpfs /tmp -v <local disk path>:/var/dell/drm/ \
      -p 8090:8090 <registry>/drm:3.2

# Using DRM

The official docs are limited, but the webapp is fairly simple. Adding
system types to manage is easy. The only tricky part is setting the
path for the export of the images. Since it is running inside docker,
the export path must start with /var/dell/drm/ and I recommend adding
another directory to support multiple export groups:
/var/dell/drm/<group>.

Each export will create a versioned catalog file. I create a symlink
to the latest catalog file which should make automated firmware
updates possible.

To use the exported files, the exported directory must be served over
NFS or HTTP/HTTPS.
