FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl \
    bb cmatrix libaa-bin

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_configs_raw /tmp/
ADD keys /tmp/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /usr/sbin/sshd -D
