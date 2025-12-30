# distance_lid_light/lid_light_node.py
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32

class LidLightNode(Node):
    def __init__(self):
        super().__init__('lid_light_node')
        self.subscription = self.create_subscription(
            Float32,
            'distance',
            self.callback,
            10
        )

    def callback(self, msg):
        d = msg.data

        if d < 0.5:
            state = 'RED (Strong)'
        elif d < 1.0:
            state = 'YELLOW (Medium)'
        else:
            state = 'GREEN (Weak)'

        self.get_logger().info(f'Distance: {d:.2f} m → LED: {state}')

def main():
    rclpy.init()
    node = LidLightNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
