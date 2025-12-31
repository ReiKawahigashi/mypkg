#!/bin/bash

source /opt/ros/humble/setup.bash
source install/setup.bash

# NG時用関数（講義資料そのまま）
ng () {
    echo "NG at line ${1}"
    res=1
}

res=0

# lid_light_node をバックグラウンドで起動
ros2 run mypkg lid_light_node > /tmp/lid_test.log 2>&1 &
LID_PID=$!

# 起動待ち
sleep 1

# -------- テストケース --------
# 30未満 → ON
ros2 topic pub /distance std_msgs/msg/Float32 "{data: 5.0}" -1
sleep 0.3
grep -q "LID LIGHT: ON" /tmp/lid_test.log || ng $LINENO

ros2 topic pub /distance std_msgs/msg/Float32 "{data: 15.0}" -1
sleep 0.3
grep -q "LID LIGHT: ON" /tmp/lid_test.log || ng $LINENO

ros2 topic pub /distance std_msgs/msg/Float32 "{data: 29.9}" -1
sleep 0.3
grep -q "LID LIGHT: ON" /tmp/lid_test.log || ng $LINENO

# 30以上 → OFF
ros2 topic pub /distance std_msgs/msg/Float32 "{data: 30.0}" -1
sleep 0.3
grep -q "LID LIGHT: OFF" /tmp/lid_test.log || ng $LINENO

ros2 topic pub /distance std_msgs/msg/Float32 "{data: 45.0}" -1
sleep 0.3
grep -q "LID LIGHT: OFF" /tmp/lid_test.log || ng $LINENO

ros2 topic pub /distance std_msgs/msg/Float32 "{data: 60.0}" -1
sleep 0.3
grep -q "LID LIGHT: OFF" /tmp/lid_test.log || ng $LINENO

ros2 topic pub /distance std_msgs/msg/Float32 "{data: 99.9}" -1
sleep 0.3
grep -q "LID LIGHT: OFF" /tmp/lid_test.log || ng $LINENO

# 境界チェック（もう一回ON）
ros2 topic pub /distance std_msgs/msg/Float32 "{data: 0.0}" -1
sleep 0.3
grep -q "LID LIGHT: ON" /tmp/lid_test.log || ng $LINENO

# 後始末
kill $LID_PID
wait $LID_PID 2>/dev/null

exit $res
