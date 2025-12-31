#!/bin/bash
set -e

# ROS2 環境
source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/alphabet_test.log
rm -f "$LOG"

# launch で2ノード同時起動（1回だけ）
ros2 launch mypkg random_to_alphabet.launch.py > "$LOG" 2>&1 &
PID=$!

# CI は遅いので十分待つ
sleep 5

# Alphabet が1回でも出ていればOK
grep "Alphabet:" "$LOG"

# 後片付け
kill $PID
