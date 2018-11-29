# docker build -t lxde .                                         # Build
# docker pull mazu01/ubuntu-lxde-xrdp-ja                         # pull
# docker tag mazu01/ubuntu-lxde-xrdp-ja lxde                     # Tag
# docker run --name=lxde -p 3389:3389 lxde                       # Run
# docker exec -it lxde bash                                      # Bash
# Start: docker restart lxde                                     # Start
# Stop:  docker stop  lxde                                       # Stop

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      tzdata locales sudo vim git net-tools wget curl \
      libnss3 libgconf-2-4 libxss1 gnupg \
      xrdp \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' > /etc/timezone \
    && locale-gen ja_JP.UTF-8 \
    && echo 'LC_ALL=ja_JP.UTF-8' > /etc/default/locale \
    && echo 'LANG=ja_JP.UTF-8' >> /etc/default/locale
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8
RUN apt-get install -y language-pack-ja-base language-pack-ja fonts-takao fcitx fcitx-mozc lxde\
    && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*
RUN wget -O vsc.deb https://go.microsoft.com/fwlink/?LinkID=760868 \
    && dpkg -i vsc.deb && rm -f vsc.deb \
    && groupadd vagrant \
    && useradd -ms /bin/bash vagrant -g vagrant \
    && echo vagrant:vagrant | chpasswd \
    && echo 'ALL ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/ALL \
    && echo 'lxsession -s LXDE -e LXDE' >> /home/vagrant/.xsession \
    && chown vagrant:vagrant /home/vagrant/.xsession

EXPOSE 3389
CMD (rm -f /var/run/xrdp/*; /etc/init.d/xrdp start; tail -f /dev/null)
