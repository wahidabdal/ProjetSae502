FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openssh-server \
    net-tools \
    iputils-ping \
    nano

RUN echo 'root:sae' | chpasswd

RUN mkdir /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

