# distance_lid_light/distance_sensor_node.py
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32
import random

class DistanceSensorNode(Node):
    def __init__(self):
        super().__init__('distance_sensor_node')
        self.publisher_ = self.create_publisher(Float32, 'distance', 10)
        self.timer = self.create_timer(0.5, self.timer_callback)

    def timer_callback(self):
        msg = Float32()
        msg.data = random.uniform(0.0, 2.0)  # 距離[m]想定
        self.publisher_.publish(msg)
        self.get_logger().info(f'Publish distance: {msg.data:.2f} m')

def main():
    rclpy.init()
    node = DistanceSensorNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
