FROM ubuntu:latest
MAINTAINER zumbrunnen@gmail.com

ENV UNIFI_VIDEO_VERSION 3.7.3
ENV DEBIAN_FRONTEND noninteractive

ADD unifi-video.patch /unifi-video.patch
ADD run.sh /run.sh

RUN apt-get update && \
  apt-get install -y apt-utils && \
  apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
  apt-get install -y wget sudo moreutils patch psmisc lsb-release && \
  apt-get install -y mongodb-server openjdk-8-jre-headless jsvc && \
  wget -q http://dl.ubnt.com/firmwares/unifi-video/${UNIFI_VIDEO_VERSION}/unifi-video_${UNIFI_VIDEO_VERSION}-Ubuntu16.04_amd64.deb && \
  dpkg -i unifi-video_${UNIFI_VIDEO_VERSION}-Ubuntu16.04_amd64.deb && \
  patch -N /usr/sbin/unifi-video /unifi-video.patch && \
  rm /unifi-video_${UNIFI_VIDEO_VERSION}-Ubuntu16.04_amd64.deb && \
  rm /unifi-video.patch && \
  chmod 755 /run.sh

VOLUME /var/lib/unifi-video /var/log/unifi-video

EXPOSE 7442 7443 7445 7446 7447 7080 6666

CMD ["/run.sh"]
