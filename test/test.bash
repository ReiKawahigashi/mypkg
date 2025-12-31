#!/bin/bash
set -e

source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/alphabet_test.log
rm -f $LOG

# launch で同時起動
ros2 launch mypkg random_to_alphabet.launch.py > $LOG 2>&1 &
PID=$!

# 起動待ち（CIは遅い）
sleep 5

# Alphabet のログが1回でも出ていればOKgrep -E "Alphabet:[ABCDE]" $LOG

# 後片付け
kill $PID || true
