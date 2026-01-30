# Quick Start Guide

This guide will help you quickly build and run the Event Ticket Platform using Docker.

## Prerequisites

- Docker installed (version 20.10+)
- Docker Compose installed (version 2.0+)

Check if Docker is installed:
```bash
docker --version
docker-compose --version
```

## Option 1: Build and Run with Docker (Recommended)

### Step 1: Build the Docker Image

```bash
docker build -t event-ticket-platform .
```

This will:
- Install all dependencies
- Build the React application
- Create a production-ready nginx container

### Step 2: Run the Container

```bash
docker run -d -p 3000:80 --name event-platform event-ticket-platform
```

### Step 3: Access the Application

Open your browser and visit: http://localhost:3000

### Step 4: Stop the Container

```bash
docker stop event-platform
```

### Step 5: Remove the Container (when done)

```bash
docker rm event-platform
```

## Option 2: Run with Docker Compose (Full Stack)

If you have a backend Spring Boot application, you can run the entire stack:

### Step 1: Update docker-compose.yml

Edit `docker-compose.yml` and update the backend image name:
```yaml
backend:
  image: your-backend-image:latest  # Change this to your actual image
```

### Step 2: Start All Services

```bash
docker-compose up -d
```

This will start:
- Frontend (port 3000)
- Backend (port 8080)
- Keycloak (port 9090)

### Step 3: Access Services

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080
- Keycloak Admin: http://localhost:9090

### Step 4: View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f frontend
```

### Step 5: Stop All Services

```bash
docker-compose down
```

## Option 3: Development Mode with Hot Reload

For development with hot-reloading:

### Step 1: Build Development Image

```bash
docker build -f Dockerfile.dev -t event-ticket-platform-dev .
```

### Step 2: Run with Volume Mount

```bash
docker run -p 5173:5173 -v $(pwd)/src:/app/src event-ticket-platform-dev
```

This mounts your source code into the container, enabling hot-reload on code changes.

## Troubleshooting

### Port Already in Use

If port 3000 is already in use, change it:

```bash
docker run -d -p 8080:80 --name event-platform event-ticket-platform
```

Then access at http://localhost:8080

### View Container Logs

```bash
docker logs event-platform
```

### Rebuild After Code Changes

```bash
# Remove old container
docker rm -f event-platform

# Rebuild image
docker build -t event-ticket-platform .

# Run new container
docker run -d -p 3000:80 --name event-platform event-ticket-platform
```

### Clean Up Everything

```bash
# Stop and remove all containers
docker-compose down

# Remove images
docker rmi event-ticket-platform

# Remove unused Docker resources
docker system prune -a
```

## Next Steps

1. Configure your backend API URL in `vite.config.ts` proxy settings
2. Update Keycloak configuration in `src/main.tsx` for your environment
3. Set up environment variables for production deployment
4. Configure HTTPS/SSL for production use

For more detailed information, see `DOCKER_SETUP.md`.
