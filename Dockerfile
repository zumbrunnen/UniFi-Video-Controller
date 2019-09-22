FROM ubuntu:bionic
LABEL maintainer="David Zumbrunnen <zumbrunnen@gmail.com>"

ENV UNIFI_VIDEO_VERSION 3.10.8
ENV DEBIAN_FRONTEND noninteractive

ADD unifi-video.patch /unifi-video.patch
ADD run.sh /run.sh

RUN apt-get update && \
    apt-get -y install apt-utils binutils moreutils wget sudo patch psmisc lsb-release libcap2 curl openjdk-8-jre-headless jsvc gnupg ca-certificates

RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN apt-get update && \
    apt-get -y install mongodb-org-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget -q https://dl.ubnt.com/firmwares/ufv/v${UNIFI_VIDEO_VERSION}/unifi-video.Ubuntu18.04_amd64.v${UNIFI_VIDEO_VERSION}.deb && \
    dpkg -i unifi-video.Ubuntu18.04_amd64.v${UNIFI_VIDEO_VERSION}.deb && \
    patch -N /usr/sbin/unifi-video /unifi-video.patch && \
    rm /unifi-video.Ubuntu18.04_amd64.v${UNIFI_VIDEO_VERSION}.deb && \
    rm /unifi-video.patch && \
    chmod 755 /run.sh

VOLUME /var/lib/unifi-video /var/log/unifi-video

# HTTP(S) Web UI + API
EXPOSE 7080/tcp 7443/tcp

# Video over HTTP(S), RTSP, NVR Discovery
EXPOSE 7445/tcp 7446/tcp 7447/tcp 10001/udp

# Inbound Camera Streams, Camera Management (NVR Side)
EXPOSE 6666/tcp 7442/tcp

# UVC-Micro Talkback (Camera Side)
EXPOSE 7004/udp

CMD ["/run.sh"]
