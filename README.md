# unifi-video-controller

This docker image runs the UniFi Video controller. It's a fork from pducharme/UniFi-Video-Controller :+1:

## Run it

```
docker run -d \
        --name unifi-video \
        --cap-add DAC_READ_SEARCH \
        --tmpfs /var/cache/unifi-video \
        -v /srv/unifi-video/data:/var/lib/unifi-video \
        -v /srv/unifi-video/videos:/var/lib/unifi-video/videos \
        -p 1935:1935 \
        -p 6666:6666 \
        -p 7004:7004/udp \
        -p 7080:7080 \
        -p 7442:7442 \
        -p 7443:7443 \
        -p 7444:7444 \
        -p 7445:7445 \
        -p 7446:7446 \
        -p 7447:7447 \
        -p 10001:10001 \
        -e TZ=Europe/Zurich \
        registry.gitlab.com/zumbrunnen/unifi-video:latest
```
