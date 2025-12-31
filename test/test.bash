#!/bin/bash
set -e

# ROS2 環境
source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/hiragana_test.log
rm -f "$LOG"

# ---- ノード起動（1ノード）----
ros2 run mypkg hiragana_node > "$LOG" 2>&1 &
PID=$!

# CI は遅いので少し待つ
sleep 3

# ---- 出力確認 ----
# Hiragana: ○○○ が出ていればOK
grep "Hiragana:" "$LOG"

# ---- 後始末 ----
kill $PID
