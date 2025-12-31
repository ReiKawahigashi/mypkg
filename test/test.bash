#!/bin/bash
set -e

# ROS2 環境
source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/alphabet_test.log
rm -f "$LOG"

# launch（1回だけ）
PID=$!

# 少し待つ
sleep 5

# Alphabet が出ているか確認
grep "Alphabet:" "$LOG"

# 後始末
kill $PID
