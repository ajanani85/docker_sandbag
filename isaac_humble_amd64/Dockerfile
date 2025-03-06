# Use NVIDIA's CUDA-enabled Ubuntu 20.04 base image
FROM isaac_ros_dev-x86_64

# Create the /home/ubuntu/ros2_ws directory
RUN mkdir -p /home/ubuntu/ros2_ws

# Set /home/ubuntu/ros2_ws as the working directory
WORKDIR /home/ubuntu/ros2_ws


# Add the ROS 2 GPG key and repository 
RUN apt install software-properties-common -y
RUN add-apt-repository universe
RUN apt update && apt install curl -y
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | apt-key add -
RUN sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2.list'
RUN apt update

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc

RUN apt install -y  ros-humble-gazebo-ros-pkgs \
                    ros-humble-gazebo-ros2-control

RUN apt install -y eog


#Add Yolo deep learning testing
RUN pip install ultralytics

# Set the entry point to a bash shell in /home/ubuntu/ros2_ws
CMD ["bash"]