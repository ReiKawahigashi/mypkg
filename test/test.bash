#!/bin/bash

source /opt/ros/humble/setup.bash
source install/setup.bash

ng () {
    echo "NG at line $1"
    res=1
}

res=0

# alphabet_node 起動
ros2 run alphabet_pkg alphabet_node > /tmp/alphabet_test.log 2>&1 &
PID=$!
sleep 1

# ---- テスト ----
ros2 topic pub /number std_msgs/msg/Int32 "{data: 5}" -1
sleep 0.3
grep -q "Alphabet: A" /tmp/alphabet_test.log || ng $LINENO

ros2 topic pub /number std_msgs/msg/Int32 "{data: 25}" -1
sleep 0.3
grep -q "Alphabet: B" /tmp/alphabet_test.log || ng $LINENO

ros2 topic pub /number std_msgs/msg/Int32 "{data: 45}" -1
sleep 0.3
grep -q "Alphabet: C" /tmp/alphabet_test.log || ng $LINENO

ros2 topic pub /number std_msgs/msg/Int32 "{data: 65}" -1
sleep 0.3
grep -q "Alphabet: D" /tmp/alphabet_test.log || ng $LINENO

ros2 topic pub /number std_msgs/msg/Int32 "{data: 85}" -1
sleep 0.3
grep -q "Alphabet: E" /tmp/alphabet_test.log || ng $LINENO

# 後始末
kill $PID
wait $PID 2>/dev/null

exit $res
