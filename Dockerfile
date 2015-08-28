FROM ubuntu:trusty
MAINTAINER Yan Cheng <me@xiaoyan.me>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Set Env
ENV AUTHORIZED_KEYS **None**
RUN mkdir /var/lib/mysql && mkdir /var/lib/html

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
ADD sources.list /sources.list
RUN chmod +x /*.sh

VOLUME  ["/var/lib/mysql","/var/lib/html"]

# Expose the server ports
EXPOSE 80 22 3306
# Excute the shell
CMD ["/run.sh"]