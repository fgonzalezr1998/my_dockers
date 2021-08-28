#! /bin/sh

/bin/bash -c "ros2 run demo_nodes_py listener &"
/bin/bash -c "ros2 run demo_nodes_cpp talker &"
/bin/bash
