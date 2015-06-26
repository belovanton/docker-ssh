FROM debian:jessie
MAINTAINER Anton Belov anton4@bk.ru

# Install system requirements
RUN apt-get update && apt-get install -y \
    emacs24-nox \
    locales \
    nginx \
    mc \
    python-pip \
    openssh-server \
    pv

# Configure locales and timezone
RUN locale-gen en_US.UTF-8
RUN locale-gen en_GB.UTF-8
RUN locale-gen fr_CH.UTF-8
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN echo "Europe/Moscow" > /etc/timezone
RUN mkdir /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

EXPOSE 22

# Supervisor config
RUN mkdir /var/log/supervisor
RUN pip install supervisor
COPY configs/supervisord.conf /etc/supervisord.conf

# Startup script
COPY scripts/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

CMD ["/opt/start.sh"]
