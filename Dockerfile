From centos:7

# Install socat, clean up, download and install DRM 3.2 and clean up
RUN yum -y install socat && yum -y clean all && rm -rf /var/cache/yum \
    && cd /tmp && curl -o drm.bin https://downloads.dell.com/FOLDER05513881M/1/DRMInstaller_3.2.0.508_A00.bin \
    && sh drm.bin -i silent \
    && rm -rf /tmp/*

# Run socat and DRM as unprivileged user
USER drmuser

# Create a volume to hold the downloaded objects
VOLUME ["/var/dell/drm/"]

COPY start.sh /

CMD ["/start.sh"]
