#!/bin/bash
# SPDXここ書く

set -e

dir=${1:-$HOME}

source /opt/ros/jazzy/setup.bash

cd $dir/ros2_ws
colcon build --packages-select mypkg
source install/setup.bash

timeout 20 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log || true

grep 'Listen: 10' /tmp/mypkg.log
