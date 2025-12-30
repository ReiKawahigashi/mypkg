from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='mypkg',
            executable='distance_sensor_node',
            output='screen'
        ),
        Node(
            package='mypkg',
            executable='lid_light_node',
            output='screen'
        )
    ])
