#!/bin/bash
# lesson10.html 5ページ準拠
# colcon test の結果を cat で確認する

set -e

if [ $# -lt 1 ]; then
    echo "usage: test.bash <workspace path>"
    exit 1
fi

WS=$1
PKG=mypkg

echo "workspace: $WS"

cd $WS

source /opt/ros/humble/setup.bash

echo "=== build ==="
colcon build --packages-select $PKG

source install/setup.bash

echo "=== test ==="
colcon test --packages-select $PKG

echo "=== test result (cat) ==="
cat build/$PKG/pytest.xml
