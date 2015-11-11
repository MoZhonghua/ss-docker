FROM ubuntu:14.02
MAINTAINER mozhonghua@sursen.net

# Switch to 163 mirror
ADD setup-163-mirror.sh /tmp
RUN chmod a+x /tmp/setup-163-mirror.sh
RUN /tmp/setup-163-mirror.sh

RUN apt-get update
RUN apt-get install python-pip -y
RUN apt-get install polipo -y
RUN pip install shadowsocks==2.8.2
RUM rm -fv /tmp/setup-163-mirror.sh
