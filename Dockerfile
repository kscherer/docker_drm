FROM ubuntu:20.04

# Install needed tools, clean up, download and install DRM, clean up
RUN apt-get update && apt-get install -y wget socat file && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && cd /tmp && wget -q -O drm.bin https://dl.dell.com/FOLDER08581866M/1/DRMInstaller_3.4.2.818.bin \
    && sh drm.bin -i silent \
    && rm -rf /tmp/*

# Run socat and DRM as unprivileged user
USER drmuser

# Create a volume to hold the downloaded objects
VOLUME ["/var/dell/drm/"]

# Expose port forwarded from socat
EXPOSE 8091

# Install start script
COPY start.sh /opt/dell/dellemcrepositorymanager/

# Start script to run DRM and socat
CMD ["/opt/dell/dellemcrepositorymanager/start.sh"]
