FROM ubuntu:20.04
LABEL mantainer="francesco-sodano"

USER root

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y wget

RUN wget --no-check-certificate https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get -y update \
    && apt-get install -y libcurl3-gnutls blobfuse fuse \
    && apt-get clean -y \
    && apt-get autoremove -y

RUN mkdir -p /mnt/blobfusetmp
RUN chown root /mnt/blobfusetmp

RUN mkdir /tmp/blobfusecfg
COPY fuse_connection.cfg /tmp/blobfusecfg

COPY run.sh /
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
