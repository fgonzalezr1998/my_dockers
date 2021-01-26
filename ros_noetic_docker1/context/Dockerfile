#! /bin/sh
FROM ubuntu:20.04

# Configure Timezone

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Install dependencies

RUN apt-get update && apt-get upgrade -y && \
apt-get install -y -q --no-install-recommends apt-utils apt-transport-https aptitude locales && \
apt-get install lsb-release -y && \
locale-gen en_US.UTF-8 && \
apt-get install gnupg2 -y

# Install ROS Noetic

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && \
apt install ros-noetic-ros-base -y

RUN useradd -d /home/noetic -s /bin/bash -rm -u 1001 noetic
WORKDIR /home/noetic

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
/bin/bash -c "source ~/.bashrc" && \
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y && \
sudo rosdep init && \
rosdep update

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
