# turtlebot-ros-pi-cluster

Repository is a WIP.

Raspberry Pi ROS cluster for the Turtlebot3 using Docker

The aim is to use a docker swarm cluster to execute ROS distributed manner. As per architecture design patterns, each ROS node has its own respective docker container. To overcome the challenges of inter-container networking (ROS requires all ports to be open and discoverable on each host) we create a simple overlay network which is attachable.

The docker compose file (v3 style) uses constraints for each service, namely to specify the deployment location of the containers. Due to the restriction of Docker swarms and interaction with peripheral devices, a spinner service is also used. This is to overcome the yet to be implemented open request [detailed here](https://github.com/docker/swarmkit/issues/1244).

The spinner service is used to make the overlay network available from the Turtlebot3. As per Docker design, networks only become available to nodes in a swarm when required by a service. We create a standalone container then attach it to the overlay network to overcome the peripheral device restrictions of swarms.

In essence, the architecture of the container-ised system uses:
    1. A Docker swarm compose file (v3) to deploy three services (uses docker deploy)
    ..1. ROS Master (on the swarm master)
    ..2. ROS Commander (on the swarm master)
    ..3. Spinner Network (on the Turtlebot3)
    2. A Docker swarm compose file (v2) (docker-compose up)
    ..1. ROS Turtlebot3 bringup


Install:

    pip3 install -r requirements.txt

