from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='alphabet_pkg',
            executable='random_number_node',
            output='screen'
        ),
        Node(
            package='alphabet_pkg',
            executable='alphabet_node',
            output='screen'
        ),
    ])
