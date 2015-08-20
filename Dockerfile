FROM ubuntu:14.04
MAINTAINER Yan Cheng <me@xiaoyan.me> 

# Set ubuntu source whith china source
COPY sources.list /etc/apt/sources.list

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
# Set Env is unused ssh key
ENV AUTHORIZED_KEYS **None**


EXPOSE 80 22 21 443
CMD ["/run.sh"]