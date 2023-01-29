#! /bin/sh

FROM ubuntu:22.04

# Install dependencies

RUN apt-get update && apt-get upgrade -y && \
apt-get install nano vim -y && \
apt-get install openjdk-19-jdk -y && \
apt-get install wget -y

# Create a new user

RUN useradd -d /home/fernando -s /bin/bash -rm -u 1001 fernando

# Setting de working directory

WORKDIR /home/fernando

# Setting 'fernando' as default user from this moment

USER fernando

# Download the 'jar' file to install the forge server and run it

RUN wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.2.0/forge-1.19.2-43.2.0-installer.jar && \
mkdir server_build && mv forge-1.19.2-43.2.0-installer.jar server_build && \
cd server_build && java -jar forge-1.19.2-43.2.0-installer.jar --installServer


COPY entrypoint.sh /
# COPY server.properties /home/fernando/minecraft_server

# USER root
# RUN chown fernando /home/fernando/minecraft_server/server.properties

ENTRYPOINT ["/entrypoint.sh"]