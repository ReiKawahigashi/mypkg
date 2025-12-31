from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='mypkg',
            executable='random_number_node',
            output='screen'
        ),
        Node(
            package='mypkg',
            executable='alphabet_node',
            output='screen'
        ),
    ])
