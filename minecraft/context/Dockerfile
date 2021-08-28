#! /bin/sh

FROM ubuntu:20.04

# Install dependencies

RUN apt-get update && apt-get upgrade -y && \
apt-get install default-jdk default-jre -y && \
apt-get install wget -y

# Create a new user

RUN useradd -d /home/fernando -s /bin/bash -rm -u 1001 fernando

# Setting de working directory

WORKDIR /home/fernando

# Setting 'fernando' as default user from this moment

USER fernando

# Download the 'jar' file to install the forge server and run it

RUN wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.4-35.1.4/forge-1.16.4-35.1.4-installer.jar && \
mkdir minecraft_server && mv forge-1.16.4-35.1.4-installer.jar minecraft_server && \
cd minecraft_server && java -jar forge-1.16.4-35.1.4-installer.jar --installServer && \
java -Xmx2048M -jar forge-1.16.4-35.1.4.jar nogui


COPY entrypoint.sh /
COPY server.properties /home/fernando/minecraft_server

USER root
RUN chown fernando /home/fernando/minecraft_server/server.properties

ENTRYPOINT ["/entrypoint.sh"]