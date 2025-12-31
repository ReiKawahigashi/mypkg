#!/bin/bash
set -e

# ROS2 環境読み込み
source /opt/ros/humble/setup.bash
source install/setup.bash

res=0
ng () {
    echo "NG at line $1"
    res=1
}

# テスト用ログ
LOG=/tmp/alphabet_test.log
rm -f $LOG

# alphabet_node をバックグラウンド起動
ros2 run mypkg alphabet_node > $LOG 2>&1 &
PID=$!

# CI では起動が遅いので待つ
sleep 2

# -------- テスト開始 --------

# A
ros2 topic pub /number std_msgs/msg/Int32 "{data: 5}" -1 \
  --wait-for-subscription-timeout 5
sleep 0.5
grep -q "Alphabet: A" $LOG || ng $LINENO

# B
ros2 topic pub /number std_msgs/msg/Int32 "{data: 25}" -1 \
  --wait-for-subscription-timeout 5
sleep 0.5
grep -q "Alphabet: B" $LOG || ng $LINENO

# C
ros2 topic pub /number std_msgs/msg/Int32 "{data: 45}" -1 \
  --wait-for-subscription-timeout 5
sleep 0.5
grep -q "Alphabet: C" $LOG || ng $LINENO

# D
ros2 topic pub /number std_msgs/msg/Int32 "{data: 65}" -1 \
  --wait-for-subscription-timeout 5
sleep 0.5
grep -q "Alphabet: D" $LOG || ng $LINENO

# E
ros2 topic pub /number std_msgs/msg/Int32 "{data: 85}" -1 \
  --wait-for-subscription-timeout 5
sleep 0.5
grep -q "Alphabet: E" $LOG || ng $LINENO

# -------- 後片付け --------
kill $PID
wait $PID 2>/dev/null

exit $res
