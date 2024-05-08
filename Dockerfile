FROM ubuntu:22.04

# DRM website: https://www.dell.com/support/home/en-us/Drivers/DriversDetails?driverid=HHV83

# Install needed tools, clean up, download and install DRM, clean up
RUN apt-get update && \
    apt-get install -y wget socat file && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget -U drm -O drm.bin https://dl.dell.com/FOLDER10693640M/1/DRMInstaller_3.4.4.908.bin && \
    sh drm.bin -i silent && \
    rm -rf /tmp/*

# Run socat and DRM as unprivileged user
USER drmuser

# Create a volume to hold the downloaded objects
VOLUME ["/var/dell/drm/"]

# Expose port forwarded from socat
EXPOSE 8091

# Install start script
COPY start.sh /opt/dell/dellrepositorymanager/

# Start script to run DRM and socat
CMD ["/opt/dell/dellrepositorymanager/start.sh"]
