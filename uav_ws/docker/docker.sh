#! /bin/bash
docker run -it \
    --gpus all --runtime=nvidia \
#    -p 5900:5900 \
    -w /home/ros2-essentials/uav_ws \
    -e ROS_LOCALHOST_ONLY=0 \
    -e ROS_DOMAIN_ID=0 \
    -e RCUTILS_COLORIZED_OUTPUT=1 \
    -e RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    -e ROS2_WS=/home/ros2-essentials/uav_ws \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /dev/dri:/dev/dri \
    -v /dev/snd:/dev/snd \
    -v /dev/shm:/dev/shm \
    -v /sim/ros2-uav/uav_ws/docker/cyclonedds.xml:/home/user/cyclonedds.xml \
    -v /sim/ros2-uav:/home/ros2-essentials \
    -v /sim/isaac-sim-cache/cache/kit:/isaac-sim/kit/cache \
    -v /sim/isaac-sim-cache/cache/ov:/home/user/.cache/ov \
    -v /sim/isaac-sim-cache/standalone/cache/ov:/home/user/.local/lib/python3.10/site-packages/omni/cache \
    -v /sim/isaac-sim-cache/cache/pip:/home/user/.cache/pip \
    -v /sim/isaac-sim-cache/cache/glcache:/home/user/.cache/nvidia/GLCache \
    -v /sim/isaac-sim-cache/cache/computecache:/home/user/.nv/ComputeCache \
    -v /sim/isaac-sim-cache/logs:/home/user/.nvidia-omniverse/logs \
    -v /sim/isaac-sim-cache/standalone/logs:/home/user/.local/lib/python3.10/site-packages/omni/logs \
    -v /sim/isaac-sim-cache/data:/home/user/.local/share/ov/data \
    -v /sim/isaac-sim-cache/standalone/data:/home/user/.local/lib/python3.10/site-packages/omni/data \
    j3soon/ros2-uav-ws \
    /bin/bash