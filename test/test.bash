#!/bin/bash
#SPDX-FileCopyrightText:2025 Rei Kawahigashi
#SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc
timeout 10 ros2 run mypkg double_calculator > /tmp/mypkg.log &

sleep 2
ros2 topic pub -1 /input_number std_msgs/msg/Int32 "{data: 10}"

cat /tmp/mypkg.log |
grep 'Published: 20'

