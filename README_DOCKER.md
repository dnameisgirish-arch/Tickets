# Docker Installation and Setup Guide

## What Has Been Created

I've created a complete Docker setup for your Event Ticket Platform:

### Files Created:
1. **Dockerfile** - Production build with nginx
2. **Dockerfile.dev** - Development build with hot-reload
3. **nginx.conf** - Nginx configuration for serving the app
4. **docker-compose.yml** - Full stack orchestration
5. **.dockerignore** - Excludes unnecessary files from build
6. **docker-run.sh** - Easy-to-use script for Linux/Mac
7. **docker-run.bat** - Easy-to-use script for Windows
8. **QUICKSTART.md** - Detailed quick start guide
9. **DOCKER_SETUP.md** - Complete Docker documentation

### Bug Fixes Applied:
- Fixed peer dependency conflict with react-day-picker (upgraded to v9)
- Fixed TypeScript errors in SimplePagination component
- Fixed Calendar component for react-day-picker v9 API
- Fixed undefined query parameter issue in attendee landing page
- Updated Dockerfile to use `--legacy-peer-deps` flag

## Installation Instructions

### Prerequisites

1. **Install Docker Desktop:**
   - **Windows/Mac**: Download from https://www.docker.com/products/docker-desktop
   - **Linux**: Follow instructions at https://docs.docker.com/engine/install/

2. **Verify Installation:**
   ```bash
   docker --version
   docker-compose --version
   ```

## Quick Start (3 Simple Steps)

### For Linux/Mac:

```bash
# Step 1: Build the Docker image
./docker-run.sh build

# Step 2: Start the application
./docker-run.sh start

# Step 3: Open your browser
# Visit: http://localhost:3000
```

### For Windows:

```cmd
REM Step 1: Build the Docker image
docker-run.bat build

REM Step 2: Start the application
docker-run.bat start

REM Step 3: Open your browser
REM Visit: http://localhost:3000
```

### Manual Docker Commands:

```bash
# Build the image
docker build -t event-ticket-platform .

# Run the container
docker run -d -p 3000:80 --name event-platform event-ticket-platform

# View logs
docker logs -f event-platform

# Stop the container
docker stop event-platform

# Remove the container
docker rm event-platform
```

## Helper Script Commands

The `docker-run.sh` (Linux/Mac) or `docker-run.bat` (Windows) scripts provide easy commands:

```bash
./docker-run.sh build      # Build Docker image
./docker-run.sh start      # Start container
./docker-run.sh stop       # Stop container
./docker-run.sh restart    # Restart container
./docker-run.sh rebuild    # Rebuild and restart
./docker-run.sh logs       # View logs
./docker-run.sh remove     # Remove container
./docker-run.sh clean      # Remove everything
```

## Docker Compose (Full Stack)

To run the complete application with backend and Keycloak:

1. **Update Backend Image** in `docker-compose.yml`:
   ```yaml
   backend:
     image: your-backend-image:latest  # Replace with your image
   ```

2. **Start All Services:**
   ```bash
   docker-compose up -d
   ```

3. **Access Services:**
   - Frontend: http://localhost:3000
   - Backend: http://localhost:8080
   - Keycloak: http://localhost:9090

4. **Stop All Services:**
   ```bash
   docker-compose down
   ```

## Development Mode

For development with hot-reload:

```bash
# Build dev image
docker build -f Dockerfile.dev -t event-ticket-platform-dev .

# Run with volume mount (Linux/Mac)
docker run -p 5173:5173 -v $(pwd)/src:/app/src event-ticket-platform-dev

# Run with volume mount (Windows PowerShell)
docker run -p 5173:5173 -v ${PWD}/src:/app/src event-ticket-platform-dev

# Run with volume mount (Windows CMD)
docker run -p 5173:5173 -v %cd%/src:/app/src event-ticket-platform-dev
```

Access at: http://localhost:5173

## What the Docker Image Contains

The production Docker image:
- ✅ Node.js 20 Alpine (build stage)
- ✅ All npm dependencies installed
- ✅ Production build of React app
- ✅ Nginx Alpine (runtime)
- ✅ Optimized for small size (~50MB)
- ✅ Serves static files efficiently
- ✅ Handles React Router correctly
- ✅ Proxies API requests to backend

## Configuration Notes

### Backend Connection
The nginx configuration proxies `/api` requests to your backend. If your backend runs separately:

1. Update `nginx.conf`:
   ```nginx
   location /api {
       proxy_pass http://your-backend-host:8080;
   }
   ```

2. Or use Docker networking with docker-compose

### Keycloak Configuration
Update in `src/main.tsx` for your environment:
```typescript
const oidcConfig = {
  authority: "http://your-keycloak-host:9090/realms/event-ticket-platform",
  client_id: "event-ticket-platform-app",
  redirect_uri: "http://your-frontend-host:3000/callback",
};
```

## Troubleshooting

### Issue: Port 3000 already in use
**Solution:** Use a different port:
```bash
docker run -d -p 8080:80 --name event-platform event-ticket-platform
# Access at http://localhost:8080
```

### Issue: Changes not reflecting
**Solution:** Rebuild the image:
```bash
./docker-run.sh rebuild
```

### Issue: Container won't start
**Solution:** Check logs:
```bash
docker logs event-platform
```

### Issue: Can't connect to backend
**Solution:**
1. Ensure backend is running
2. Check nginx.conf proxy settings
3. Verify network connectivity between containers

### Issue: Out of disk space
**Solution:** Clean up Docker:
```bash
docker system prune -a
```

## Production Deployment Checklist

Before deploying to production:

- [ ] Update Keycloak URLs to production instance
- [ ] Configure environment-specific settings
- [ ] Enable HTTPS/SSL
- [ ] Set up proper CORS configuration
- [ ] Configure logging and monitoring
- [ ] Use Docker secrets for sensitive data
- [ ] Set up health checks
- [ ] Configure backup and disaster recovery
- [ ] Use a reverse proxy (nginx/traefik)
- [ ] Implement rate limiting
- [ ] Set up CI/CD pipeline

## Next Steps

1. ✅ Build the Docker image
2. ✅ Run the container
3. ✅ Access the application
4. 🔧 Configure backend connection
5. 🔧 Set up Keycloak realm
6. 🔧 Test the full application flow

## Additional Resources

- Docker Documentation: https://docs.docker.com
- Docker Compose: https://docs.docker.com/compose
- Nginx Documentation: https://nginx.org/en/docs
- React Router: https://reactrouter.com

## Support

For detailed information, see:
- `QUICKSTART.md` - Quick start guide
- `DOCKER_SETUP.md` - Comprehensive Docker setup
- Project README.md - Application documentation

---

**Your Docker setup is ready to use!** 🐳🚀
