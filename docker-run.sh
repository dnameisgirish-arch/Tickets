#!/bin/bash

echo "================================"
echo "Event Ticket Platform - Docker"
echo "================================"
echo ""

IMAGE_NAME="event-ticket-platform"
CONTAINER_NAME="event-platform"
PORT="3000"

if [ "$1" == "build" ]; then
    echo "Building Docker image..."
    docker build -t $IMAGE_NAME .
    echo ""
    echo "Build complete! Run './docker-run.sh start' to start the application."

elif [ "$1" == "start" ]; then
    echo "Starting container..."
    docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME
    echo ""
    echo "Application started!"
    echo "Access it at: http://localhost:$PORT"
    echo ""
    echo "To view logs: ./docker-run.sh logs"
    echo "To stop: ./docker-run.sh stop"

elif [ "$1" == "stop" ]; then
    echo "Stopping container..."
    docker stop $CONTAINER_NAME
    echo "Container stopped."

elif [ "$1" == "remove" ]; then
    echo "Removing container..."
    docker rm $CONTAINER_NAME
    echo "Container removed."

elif [ "$1" == "logs" ]; then
    echo "Showing logs (Ctrl+C to exit)..."
    docker logs -f $CONTAINER_NAME

elif [ "$1" == "restart" ]; then
    echo "Restarting..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME
    echo "Application restarted!"
    echo "Access it at: http://localhost:$PORT"

elif [ "$1" == "rebuild" ]; then
    echo "Rebuilding and restarting..."
    docker stop $CONTAINER_NAME 2>/dev/null
    docker rm $CONTAINER_NAME 2>/dev/null
    docker build -t $IMAGE_NAME .
    docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME
    echo "Application rebuilt and restarted!"
    echo "Access it at: http://localhost:$PORT"

elif [ "$1" == "clean" ]; then
    echo "Cleaning up..."
    docker stop $CONTAINER_NAME 2>/dev/null
    docker rm $CONTAINER_NAME 2>/dev/null
    docker rmi $IMAGE_NAME 2>/dev/null
    echo "Cleanup complete."

else
    echo "Usage: ./docker-run.sh [command]"
    echo ""
    echo "Commands:"
    echo "  build     - Build the Docker image"
    echo "  start     - Start the container"
    echo "  stop      - Stop the container"
    echo "  restart   - Restart the container"
    echo "  rebuild   - Rebuild image and restart container"
    echo "  remove    - Remove the container"
    echo "  logs      - View container logs"
    echo "  clean     - Remove container and image"
    echo ""
    echo "Quick start:"
    echo "  1. ./docker-run.sh build"
    echo "  2. ./docker-run.sh start"
    echo "  3. Open http://localhost:$PORT"
fi
