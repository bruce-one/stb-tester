FROM d53ce8a9c049
MAINTAINER Bryce

ENV DEBIAN_FRONTEND noninteractive

ADD ./setup-dependencies.sh /setup-dependencies.sh
RUN chmod 755 /setup-dependencies.sh

RUN /setup-dependencies.sh

ADD ./lircd.conf /etc/lirc/lircd.conf
ADD ./lircmd.conf /etc/lirc/lircmd.conf
ADD ./hardware.conf /etc/lirc/hardware.conf

#RUN service lirc start

VOLUME ["/dev", "/tests"]

CMD ["/bin/bash"]
