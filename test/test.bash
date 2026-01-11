#!/bin/bash
#SPDX-FileCopyrightText:2025 Rei Kawahigashi
#SPDX-License-Identifier: BSD-3-Clause

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
