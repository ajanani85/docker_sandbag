# Use NVIDIA's CUDA-enabled Ubuntu 20.04 base image
FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DISPLAY=:1

# Update package lists, upgrade system, and install base dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    software-properties-common \
    curl \
    gnupg2 \
    lsb-release \
    build-essential \
    cmake \
    git \
    python3-pip \
    python3-numpy \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install vcstool

# Add universe & multiverse repositories (needed for ROS 2 and Gazebo)
RUN add-apt-repository universe && add-apt-repository multiverse

# Add ROS 2 key & sources (without using deprecated apt-key)
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL http://repo.ros2.org/repos.key | tee /etc/apt/keyrings/ros2-archive-keyring.gpg > /dev/null

RUN echo "deb [signed-by=/etc/apt/keyrings/ros2-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu focal main" | tee /etc/apt/sources.list.d/ros2.list

# Install ROS 2 Humble and Gazebo
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    ros-humble-gazebo-ros-pkgs \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init && rosdep update

# Install OpenCV with CUDA support
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    cmake \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Source ROS 2 in every new shell session
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]