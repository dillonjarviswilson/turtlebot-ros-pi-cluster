# Dillon Wilson - Turtlebot3 ROS ARM
FROM ros:kinetic-ros-core

RUN apt-get update -y
RUN apt-get upgrade -y

# install required ROS packages
# run as seperate stages so caching assists in cases of failure
RUN apt-get install ros-kinetic-joy -y
RUN apt-get install ros-kinetic-teleop-twist-joy -y
RUN apt-get install ros-kinetic-teleop-twist-keyboard -y
RUN apt-get install ros-kinetic-laser-proc -y
RUN apt-get install ros-kinetic-rgbd-launch -y
RUN apt-get install ros-kinetic-depthimage-to-laserscan -y
RUN apt-get install ros-kinetic-rosserial-arduino  -y
RUN apt-get install ros-kinetic-rosserial-python  -y
RUN apt-get install ros-kinetic-rosserial-server  -y
RUN apt-get install ros-kinetic-rosserial-client  -y
RUN apt-get install ros-kinetic-rosserial-msgs  -y
RUN apt-get install ros-kinetic-amcl  -y
RUN apt-get install ros-kinetic-map-server  -y
RUN apt-get install ros-kinetic-move-base  -y
RUN apt-get install ros-kinetic-urdf  -y
RUN apt-get install ros-kinetic-xacro  -y
RUN apt-get install ros-kinetic-compressed-image-transport -y 
RUN apt-get install ros-kinetic-rqt-image-view -y 
RUN apt-get install ros-kinetic-gmapping -y 
RUN apt-get install ros-kinetic-navigation -y
RUN apt-get install ros-kinetic-interactive-markers -y
RUN apt-get install ros-kinetic-tf -y



# Get the Turtlebot3 packages
WORKDIR /root/catkin_ws/src/

RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git

RUN ls -alt

RUN apt-get install -y protobuf-compiler ros-kinetic-catkin
 
RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash"

WORKDIR /root/catkin_ws

RUN ls -alt
RUN pwd


# Make (install) the Turtlebot3 packages
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && catkin_make"

CMD /bin/bash

