#!/bin/bash
# SPDX-License-Identifier: Apache-2.0

set -e

dir=${1:-"$HOME"}

# ROS2 setup
source /opt/ros/jazzy/setup.bash

cd "$dir/ros2_ws"

colcon build --packages-select mypkg

source install/setup.bash

# run launch, ignore failure
timeout 20 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log || true

# check output
grep 'Listen: 10' /tmp/mypkg.log
