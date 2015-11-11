FROM ss/base
MAINTAINER mozhonghua@sursen.net

RUN mkdir -pv /etc/shadowsocks
VOLUME /etc/shadowsocks

ADD start.sh /bin/
RUN chmod a+x /bin/start.sh

ENTRYPOINT ["/bin/start.sh"]
