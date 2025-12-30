import random

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32


class DistanceSensorNode(Node):

    def __init__(self):
        super().__init__('distance_sensor_node')
        self.publisher_ = self.create_publisher(Float32, 'distance', 10)
        self.timer = self.create_timer(1.0, self.timer_callback)

    def timer_callback(self):
        msg = Float32()
        msg.data = random.uniform(0.0, 100.0)
        self.publisher_.publish(msg)


def main():
    rclpy.init()
    node = DistanceSensorNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
