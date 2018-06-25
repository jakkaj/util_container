FROM ubuntu:16.04
USER root

#apt installs
RUN apt-get update


RUN apt-get install openssh-server -y

RUN apt-get install curl wget -y

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install iputils-ping

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN mv kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl

RUN apt-get install sudo

 #customisations and things
RUN mkdir -p /var/run/sshd

#user mode stuff

RUN adduser --disabled-password --gecos "" acsuser && \
  echo "acsuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/acsuser


RUN npm install -g kubecfg


RUN chmod 777 -R /home/acsuser/.config

WORKDIR /home/acsuser

RUN find /home/acsuser -type d -user root -exec chown -R acsuser: {} +

## If you want to be able to SSH in to this. 
#RUN echo "root:temppw" | chpasswd
#RUN echo "PermitRootLogin yes" > /etc/ssh/sshd_config
#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]


USER acsuser
RUN echo "alias k=\"kubectl\"" > ~/.bashrc
RUN echo "alias kk='watch -n 3 kubectl get nodes,svc,pods'" > ~/.bashrc
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc
CMD ["/bin/bash"]