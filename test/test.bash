#!/bin/bash
set -e

# ROS2 環境
source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/alphabet_test.log
rm -f $LOG

# ---- launch で2ノード同時起動 ----
ros2 launch mypkg random_to_alphabet.launch.py > $LOG 2>&1 &
PID=$!

# CI は遅いので十分待つ（重要）
sleep 5

# ---- 出力確認 ----
# random_number_node は 1 秒周期で publish するので
# 少なくとも A〜E のどれかは必ず出る

grep -E "Alphabet: [ABCDE]" $LOG

# ---- 後片付け ----
kill $PID
wait $PID 2>/dev/null || true
