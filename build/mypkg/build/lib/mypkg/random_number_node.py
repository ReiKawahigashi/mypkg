import random

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32


class RandomNumberNode(Node):

    def __init__(self):
        super().__init__('random_number_node')
        self.publisher_ = self.create_publisher(Int32, 'number', 10)
        self.timer = self.create_timer(1.0, self.timer_callback)

    def timer_callback(self):
        msg = Int32()
        msg.data = random.randint(0, 100)
        self.publisher_.publish(msg)
        self.get_logger().info(f'Publish number: {msg.data}')


def main():
    rclpy.init()
    node = RandomNumberNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
