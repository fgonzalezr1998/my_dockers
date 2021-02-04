#! /bin/sh

passwd noetic
echo 'export ROS_MASTER_URI=http://localhost:11311' >> /home/noetic/.bashrc
echo 'export ROS_IP=localhost' >> /home/noetic/.bashrc
echo 'export ROS_HOSTNAME=localhost' >> /home/noetic/.bashrc
cd /home/noetic
mkdir -p catkin_ws/src && cd /home/noetic/catkin_ws
catkin_make
/bin/bash
