#!/bin/bash
Color_off='\033[0m'
Yellow='\033[1;33m'
sudo docker stop glovo_server
sudo docker rm glovo_server
echo -e "${Yellow}Docker container removed!${Color_off}"
