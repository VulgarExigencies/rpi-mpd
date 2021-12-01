FROM amd64/alpine:3.13

LABEL org.opencontainers.image.authors="Refreshingly Unconcerned Tith The Vulgar Exigencies of Veracity <refreshinglyunconcerned@gmail.com>" \
    org.opencontainers.image.title="MPD" \
    org.opencontainers.image.description="AlpineLinux with MPD on amd64 arch" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" \
    org.opencontainers.image.url="https://hub.docker.com/u/refreshinglyunconcerned/mpd" \
    org.opencontainers.image.source="https://github.com/VulgarExigencies/rpi-mpd"

RUN set -eux ; \
    apk --no-cache add \
    mpd \
    mpc \
    ; \
    mkdir /var/log/mpd/data/ ; \
    chown -R mpd:audio /var/lib/mpd ; \
    mkdir -p /run/mpd/ ; \
    chown -R mpd:audio /run/mpd/ ; \
    #chown mpd:audio /etc/mpd.conf ; \
    cp /etc/mpd.conf /etc/mpd.conf.backup

COPY mpd.conf /etc/mpd.conf

VOLUME ["/var/lib/mpd"]

EXPOSE 6600 8000

CMD ["/usr/bin/mpd", "--no-daemon", "--stdout", "/etc/mpd.conf"]
