#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 ReiKawahigashi
#SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32


class DoubleCalculator(Node):
    def __init__(self):
        super().__init__('double_calculator')

        # Subscriber
        self.sub = self.create_subscription(
            Int32,
            'input_number',
            self.callback,
            10
        )

        # Publisher
        self.pub = self.create_publisher(
            Int32,
            'output_number',
            10
        )

    def callback(self, msg):
        result = msg.data * 2

        out_msg = Int32()
        out_msg.data = result
        self.pub.publish(out_msg)

        self.get_logger().info(
            f'Received: {msg.data}, Published: {result}'
        )


def main():
    rclpy.init()
    node = DoubleCalculator()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()
