FROM ubuntu:18.10
WORKDIR /app
RUN apt-get update && apt-get install -y \
    net-tools \
    curl \
    nodejs \
    npm \
    perl \
    python \
    default-jdk \
    openssl \
    vim \
    openssh-server \
    telnet \
    git \
    tofrodos \
    jq

ENV TZ=Canada/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y vnc4server xvfb
#RUN apt-get install -y ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal gnome-core
RUN apt-get install -y xfce4 xfce4-goodies

RUN mkdir /var/run/sshd
RUN echo 'root:abc123' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/\#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN sed -i 's/\#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/authorized_keys
RUN echo "IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

# .profile
RUN echo "export DISPLAY=\$(hostname):1" >> /root/.profile

# VNC
RUN mkdir ~/.vnc
COPY ./passwd /root/.vnc
RUN chmod 755 /root/.vnc
RUN chmod 600 /root/.vnc/passwd
# COPY ./xstartup /root/.vnc
# RUN chmod 755 /root/.vnc/xstartup

# ssh
EXPOSE 22222:22
# vnc
EXPOSE 25901:5901
COPY ./docker-entrypoint.sh /
RUN dos2unix /docker-entrypoint.sh
#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
