FROM ubuntu:latest
WORKDIR /app
RUN apt-get update && apt-get install -y \
    net-tools \
    curl \
    nodejs \
    npm \
    perl \
    python \
    openssl \
    vim \
    openssh-server \
    telnet

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
RUN  echo "IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

EXPOSE 22222:22

CMD ["/usr/sbin/sshd", "-D"]
