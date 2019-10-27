 #!/bin/bash
sudo ip link set vcan0 down
sudo ip link del dev vcan0
ip a | grep vcan0
echo "done."
exit 0
