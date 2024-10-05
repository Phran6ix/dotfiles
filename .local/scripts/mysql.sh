#!/bin/bash

# Container name
CONTAINER_NAME="mysql"

# MySQL root password
MYSQL_ROOT_PASSWORD="password"

# Database name
MYSQL_DATABASE="touramp"

# MySQL user and password
MYSQL_USER="touramp"
MYSQL_PASSWORD="touramp01"

# Host port to map to container's 3306
HOST_PORT=3306

# Data directory on host to persist MySQL data
DATA_DIR="/path/to/mysql/data"

# Create the data directory if it doesn't exist
mkdir -p $DATA_DIR

# Run the MySQL container
docker run --name $CONTAINER_NAME \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    -e MYSQL_DATABASE=$MYSQL_DATABASE \
    -e MYSQL_USER=$MYSQL_USER \
    -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
    -p $HOST_PORT:3306 \
    -v $DATA_DIR:/var/lib/mysql \
    -d mysql:8.0 \
    --character-set-server=utf8mb4 \
    --collation-server=utf8mb4_unicode_ci

# Check if the container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "MySQL container is running."
    echo "To connect: mysql -h 127.0.0.1 -P $HOST_PORT -u $MYSQL_USER -p"
else
    echo "Failed to start MySQL container. Check docker logs for more information."
fi
