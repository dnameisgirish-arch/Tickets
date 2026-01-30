# Docker Setup Guide

This guide will help you build and run the Event Ticket Platform using Docker.

## Prerequisites

- Docker installed (version 20.10 or higher)
- Docker Compose installed (version 2.0 or higher)

## Quick Start

### Option 1: Run Frontend Only

If you already have the backend and Keycloak running locally:

```bash
# Build the Docker image
docker build -t event-ticket-platform-frontend .

# Run the container
docker run -p 3000:80 event-ticket-platform-frontend
```

The application will be available at http://localhost:3000

### Option 2: Run Full Stack with Docker Compose

To run the entire application stack including frontend, backend, and Keycloak:

1. **Update the backend image** in `docker-compose.yml`:
   Replace `your-backend-image:latest` with your actual Spring Boot backend image.

2. **Start all services**:
```bash
docker-compose up -d
```

3. **Access the application**:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080
   - Keycloak: http://localhost:9090

4. **Stop all services**:
```bash
docker-compose down
```

## Building the Image

### Development Build

```bash
docker build -t event-ticket-platform-frontend:dev .
```

### Production Build

```bash
docker build -t event-ticket-platform-frontend:latest .
```

## Configuration

### Environment Variables

The application uses hardcoded configuration in `src/main.tsx`. For production, you may want to make these configurable:

- `authority`: Keycloak realm URL
- `client_id`: OIDC client ID
- `redirect_uri`: Callback URL after authentication

### Backend Connection

The nginx configuration in `nginx.conf` proxies API requests to the backend service. Update the proxy_pass URL if your backend runs on a different host/port:

```nginx
location /api {
    proxy_pass http://your-backend-host:8080;
    ...
}
```

## Troubleshooting

### Frontend can't connect to backend

1. Check if backend service is running:
```bash
docker-compose ps
```

2. Check nginx logs:
```bash
docker-compose logs frontend
```

### Build fails

1. Clear Docker build cache:
```bash
docker builder prune -a
```

2. Rebuild from scratch:
```bash
docker-compose build --no-cache
```

### Port conflicts

If ports 3000, 8080, or 9090 are already in use, update the port mappings in `docker-compose.yml`:

```yaml
ports:
  - "YOUR_PORT:80"  # Change YOUR_PORT to an available port
```

## Docker Commands Cheat Sheet

```bash
# Build image
docker build -t event-ticket-platform-frontend .

# Run container
docker run -d -p 3000:80 event-ticket-platform-frontend

# View running containers
docker ps

# View logs
docker logs <container_id>

# Stop container
docker stop <container_id>

# Remove container
docker rm <container_id>

# Remove image
docker rmi event-ticket-platform-frontend

# Start docker-compose services
docker-compose up -d

# Stop docker-compose services
docker-compose down

# View service logs
docker-compose logs -f frontend

# Rebuild services
docker-compose build

# Remove all stopped containers and unused images
docker system prune -a
```

## Production Deployment

For production deployment:

1. Update OIDC configuration to use production Keycloak instance
2. Configure proper CORS settings
3. Use environment-specific configuration
4. Enable HTTPS
5. Set up proper logging and monitoring
6. Use a reverse proxy (nginx/traefik) in front of services
7. Implement health checks
8. Use Docker secrets for sensitive data

## Notes

- The Dockerfile uses a multi-stage build to minimize the final image size
- The production image uses nginx-alpine for a lightweight footprint
- Node modules and build artifacts are excluded via .dockerignore
- The application uses React Router, so nginx is configured to handle client-side routing
