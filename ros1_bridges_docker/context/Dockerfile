#! /bin/sh
FROM ubuntu:20.04

# Configure Timezone

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y

## Add a new user, add it to sudoers and set its passwd

RUN useradd -d /home/gentlebots -s /bin/bash -rm -u 1001 gentlebots
RUN adduser gentlebots sudo
RUN echo "gentlebots:R0b0t1c4$" | chpasswd

# Install ROS Noetic

## Install dependencies

RUN apt-get install -y -q --no-install-recommends apt-utils \
apt-transport-https aptitude locales && \
apt-get install lsb-release -y && \
locale-gen en_US.UTF-8 && \
apt-get install gnupg2 -y

## Noetic Installation

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && \
apt install ros-noetic-ros-base -y


RUN apt install python3-rosdep python3-rosinstall \
python3-rosinstall-generator python3-wstool build-essential -y && \
rosdep init && \
rosdep update


# Install ROS2 Foxy from source

## Set locale

RUN locale && \
apt update && apt install locales -y && \
locale-gen en_US en_US.UTF-8 && \
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
export LANG=en_US.UTF-8 && \
locale

## Add the ROS2 apt repository

RUN apt update && apt install curl gnupg2 lsb-release -y && \
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

## Install development tools and ROS tools

RUN apt update && apt install -y \
build-essential \
cmake \
git \
libbullet-dev \
python3-colcon-common-extensions \
python3-flake8 \
python3-pip \
python3-pytest-cov \
python3-rosdep \
python3-setuptools \
python3-vcstool \
wget && \
python3 -m pip install -U \
argcomplete \
flake8-blind-except \
flake8-builtins \
flake8-class-newline \
flake8-comprehensions \
flake8-deprecated \
flake8-docstrings \
flake8-import-order \
flake8-quotes \
pytest-repeat \
pytest-rerunfailures \
pytest && \
apt install --no-install-recommends -y \
libasio-dev \
libtinyxml2-dev && \
apt install --no-install-recommends -y \
libcunit1-dev

RUN rosdep update

## user 'gentlebots' user from here to the end

USER gentlebots
WORKDIR /home/gentlebots

## Create Workspace and import the packages and dependencies

RUN mkdir -p ~/foxy_ws/src && \
cd ~/foxy_ws && \
wget https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos && \
vcs import src < ros2.repos

USER root

RUN cd /home/gentlebots/foxy_ws && \
rosdep install --from-paths src --ignore-src --rosdistro foxy -y --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

USER gentlebots
WORKDIR /home/gentlebots

## Compile the ROS2 Workspace

RUN cd ~/foxy_ws && \
colcon build --symlink-install --packages-skip ros1_bridge
RUN echo 'source ~/foxy_ws/install/setup.bash' >> ~/.bashrc && \
/bin/bash -c "source ~/.bashrc"

## Source ROS1 Environment

RUN /bin/bash -c "source /opt/noetic/setup.bash"

## Compile ros1_bridge

RUN colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
