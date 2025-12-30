import random

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32


# クラスの前は2行空ける
class DistanceSensorNode(Node):

    def __init__(self):
        super().__init__('distance_sensor_node') # シングルクォーテーションにする
        self.publisher_ = self.create_publisher(Float32, 'distance', 10)
        self.timer = self.create_timer(1.0, self.timer_callback)

    def timer_callback(self):
        msg = Float32()
        msg.data = random.uniform(0.0, 100.0)
        self.publisher_.publish(msg)


# 関数の前も2行空ける
def main():
    rclpy.init()
    node = DistanceSensorNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
