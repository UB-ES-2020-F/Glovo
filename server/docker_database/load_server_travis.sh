#!/bin/bash
sudo echo


Color_off='\033[0m'
Yellow='\033[1;33m'
if ! command -v docker &> /dev/null
then
    echo -e "${Yellow}docker command not found!${Color_off}"
    exit
fi

if ! sudo docker image inspect postgres:latest &> /dev/null
then
    echo -e "${Yellow}postgres image not found,${Color_off}"
    echo -e "${Yellow}pulling latest postgres image.....${Color_off}"
    sudo docker pull postgres:latest
fi

sudo docker run -d --name glovo_server \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_USER=glovodev \
    -e POSTGRES_DB=glovodb \
    -p 5432:5432 \
    postgres:latest

until sudo docker exec glovo_server psql -U glovodev -d glovodb &> /dev/null; do
    echo -e "${Yellow}Waiting for postgres server...${Color_off}"
    sleep 1
done
dotnet ef database update --project ../glovo_webapi/glovo_webapi
sudo docker cp db_script.sql glovo_server:/db_script.sql
sudo docker exec glovo_server psql -U glovodev -d glovodb -a -f /db_script.sql

echo -e "${Yellow}Server started!${Color_off}"
