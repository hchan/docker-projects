FROM ubuntu:18.10
WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    net-tools nginx socat iptables netcat \
    iputils-ping \
    curl wget \
    nodejs \
    npm \
    perl \
    python3 \
    default-jdk maven gradle \
    openssl \
    vim nano \
    openssh-server \
    telnet \
    git \
    tofrodos dos2unix \
    jq \
    sudo

ENV TZ=Canada/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y vnc4server xvfb
#RUN apt-get install -y ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal gnome-core
RUN apt-get install -y xfce4 xfce4-goodies

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN mkdir -p /root/.config/xfce4/terminal
COPY ./terminalrc /root/.config/xfce4/terminal
RUN dos2unix /root/.config/xfce4/terminal/terminalrc



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
RUN echo "export LANGUAGE=en_US.utf8" >> /etc/profile
RUN echo "export LANG=en_US.utf8" >> /etc/profile
RUN echo "export LC_ALL=en_US.utf8" >> /etc/profile

RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/authorized_keys
RUN echo "IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

# toor (root backwards)
RUN useradd -m -c "Toor the rooT" toor -s /bin/bash
ADD id_rsa /home/toor/.ssh/id_rsa
ADD id_rsa.pub /home/toor/.ssh/authorized_keys
RUN chmod 700 /home/toor/.ssh/id_rsa
RUN chmod 600 /home/toor/.ssh/authorized_keys

# .profile
RUN echo "export DISPLAY=\$(hostname):1" >> /etc/profile
RUN echo "xhost +" >> /etc/profile


# VNC
RUN mkdir /root/.vnc
COPY ./passwd /root/.vnc
RUN chmod 755 /root/.vnc
RUN chmod 600 /root/.vnc/passwd
RUN mkdir /home/toor/.vnc
COPY ./passwd /home/toor/.vnc
RUN chmod 755 /home/toor/.vnc
RUN chmod 600 /home/toor/.vnc/passwd


# desktop
RUN sed -i 's/\#Exec=xfce4-terminal/xfce4-terminal --maximize/' /usr/share/applications/xfce4-terminal.desktop


COPY ./.gitconfig /root
COPY ./.gitconfig /home/toor

# more toor stuff
RUN chown -R toor:toor /home/toor
RUN echo "toor    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# ssh
EXPOSE 22222:22
# vnc
EXPOSE 25901:5901
# nginx (see docker-entrypoint.sh for port forwarding)
EXPOSE 18888:18888

COPY ./docker-entrypoint.sh /
RUN dos2unix /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/usr/sbin/sshd", "-D"]
