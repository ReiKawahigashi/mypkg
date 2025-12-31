#!/bin/bash
set -e

source /opt/ros/humble/setup.bash
source install/setup.bash

LOG=/tmp/alphabet_test.log
rm -f $LOG

res=0
ng () {
    echo "NG at line $1"
    res=1
}

# -------- alphabet_node 起動 --------
ros2 run mypkg alphabet_node > $LOG 2>&1 &
PID=$!

# -------- node が見えるまで待つ --------
echo "Waiting for alphabet_node to appear..."
for i in {1..20}; do
    if ros2 node list | grep -q "/alphabet_node"; then
        echo "alphabet_node is running"
        break
    fi
    sleep 0.5
done

# それでも起動していなければ失敗
if ! ros2 node list | grep -q "/alphabet_node"; then
    echo "alphabet_node failed to start"
    cat $LOG
    kill $PID 2>/dev/null || true
    exit 1
fi

# -------- テスト開始 --------

# A
ros2 topic pub /number std_msgs/msg/Int32 "{data: 5}" -1
sleep 0.5
grep -q "Alphabet: A" $LOG || ng $LINENO

# B
ros2 topic pub /number std_msgs/msg/Int32 "{data: 25}" -1
sleep 0.5
grep -q "Alphabet: B" $LOG || ng $LINENO

# C
ros2 topic pub /number std_msgs/msg/Int32 "{data: 45}" -1
sleep 0.5
grep -q "Alphabet: C" $LOG || ng $LINENO

# D
ros2 topic pub /number std_msgs/msg/Int32 "{data: 65}" -1
sleep 0.5
grep -q "Alphabet: D" $LOG || ng $LINENO

# E
ros2 topic pub /number std_msgs/msg/Int32 "{data: 85}" -1
sleep 0.5
grep -q "Alphabet: E" $LOG || ng $LINENO

# -------- 後片付け --------
kill $PID
wait $PID 2>/dev/null || true

exit $res
