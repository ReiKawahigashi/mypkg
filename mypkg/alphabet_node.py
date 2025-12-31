import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32


class AlphabetNode(Node):

    def __init__(self):
        super().__init__('alphabet_node')
        self.subscription = self.create_subscription(
            Int32,
            'number',
            self.listener_callback,
            10
        )

    def listener_callback(self, msg):
        n = msg.data

        if n < 20:
            char = 'A'
        elif n < 40:
            char = 'B'
        elif n < 60:
            char = 'C'
        elif n < 80:
            char = 'D'
        else:
            char = 'E'

        self.get_logger().info(f'Number: {n} -> Alphabet: {char}')


def main():
    rclpy.init()
    node = AlphabetNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
