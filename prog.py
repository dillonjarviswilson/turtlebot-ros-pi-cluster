import sh
from sh import ls
import sys
from io import StringIO
import codecs

buffer = StringIO()
output = sh.docker("stack", "ls",_in=sys.stdin, _err=sys.stderr)


if "t-bt" not in output and "3" not in output:
    print("Starting Stack on ros-cluster")
    output = sh.docker("stack", "deploy", "-c","/home/pi/ros-cluster/docker-alt.yml", "t-bt" ,_out=sys.stdout,_in=sys.stdin, _err=sys.stderr)

else:
    print("Stack already running on ros-cluster")


ros_turtlebot = sh.ssh.bake("pi@turtlebot-ros.wireless.leeds.ac.uk")

output = ros_turtlebot("docker network ls")
if "ros-overlay-network" not in output:
    print("Network is not availible to attach to from turtlebot-ros")
    exit()

else:
    print("Network is availible to attach to from turtlebot-ros")


sh.docker("ps", _out=buffer)

content = buffer.getvalue().encode('utf-8').strip()


s2 = "t-bt_ros_commander.1."
commander_container = str(content)[str(content).index(s2) + len(s2):]


commander_container_name = "t-bt_ros_commander.1." + commander_container.split()[0]

print("The commander container name is: {}".format(commander_container_name))




#check if dir exists
output = ros_turtlebot("cd ~/ros-bot")
output = ros_turtlebot("docker ps")


if "ros-bot_ros_bot_1" not in output:
    output = ros_turtlebot("cd ~/ros-bot && docker-compose up -d", _out=sys.stdout,_in=sys.stdin, _err=sys.stderr)
    print(output)
else:
    print("ros-bot is up and running")
    output = sh.docker("exec", "-it", commander_container_name, "bash",_out=sys.stdout,_tty_in=True)

#print(output)
