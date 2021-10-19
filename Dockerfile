From centos:7

# Install socat, clean up, download and install DRM 3.3.2 and clean up
RUN yum -y install socat wget && yum -y clean all && rm -rf /var/cache/yum \
    && cd /tmp && wget -q -O drm.bin https://dl.dell.com/FOLDER07638557M/1/DRMInstaller_3.3.2.735.bin \
    && sh drm.bin -i silent \
    && rm -rf /tmp/*

# Run socat and DRM as unprivileged user
USER drmuser

# Create a volume to hold the downloaded objects
VOLUME ["/var/dell/drm/"]

COPY start.sh /

CMD ["/start.sh"]
