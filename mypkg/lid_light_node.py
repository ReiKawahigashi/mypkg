import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32


class LidLightNode(Node):

    def __init__(self):
        super().__init__('lid_light_node')
        self.subscription = self.create_subscription(
            Float32,
            'distance',
            self.listener_callback,
            10,
        )

    def listener_callback(self, msg):
        if msg.data < 30.0:
            self.get_logger().info('LID LIGHT: ON')
        else:
            self.get_logger().info('LID LIGHT: OFF')


def main():
    rclpy.init()
    node = LidLightNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
