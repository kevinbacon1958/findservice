FROM archlinux/base:latest
RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm whois awk grep nmap git patch gcc make bison flex
COPY ./findservice.sh /
RUN chmod +x /findservice.sh

RUN git clone https://github.com/dneufeld/unicornscan.git
RUN curl https://raw.githubusercontent.com/SlackBuildsOrg/slackbuilds/master/network/unicornscan/patches/unicornscan-0.4.7-gcc5.patch > unicorn.patch
RUN patch unicornscan/src/unilib/tsc.c unicorn.patch
RUN cd unicornscan && ./configure CFLAGS=-D_GNU_SOURCE && make && make install

ENTRYPOINT ["/findservice.sh"]
CMD []
