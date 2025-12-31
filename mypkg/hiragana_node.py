import random

import rclpy
from rclpy.node import Node


class HiraganaNode(Node):

    def __init__(self):
        super().__init__('hiragana_node')

        self.hiragana_list = [
            'あ', 'い', 'う', 'え', 'お',
            'か', 'き', 'く', 'け', 'こ',
            'さ', 'し', 'す', 'せ', 'そ',
            'た', 'ち', 'つ', 'て', 'と',
            'な', 'に', 'ぬ', 'ね', 'の',
            'は', 'ひ', 'ふ', 'へ', 'ほ',
            'ま', 'み', 'む', 'め', 'も',
            'や', 'ゆ', 'よ',
            'ら', 'り', 'る', 'れ', 'ろ',
            'わ', 'を', 'ん'
        ]

        self.timer = self.create_timer(1.0, self.timer_callback)

    def timer_callback(self):
        chars = random.sample(self.hiragana_list, 3)
        text = ''.join(chars)

        # ★ テストが探しているログ
        self.get_logger().info(f'Hiragana: {text}')


def main():
    rclpy.init()
    node = HiraganaNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
