FROM ubuntu:20.04
COPY ./work.sh  /home/work.sh
COPY ./sources.list /etc/apt/sources.list
RUN  apt update && \
    apt install  mysql-client nfs-common  -y    && \
    mkdir /data && \
    chmod 777 -R  /data && \
    apt clean