@echo off
setlocal

set IMAGE_NAME=event-ticket-platform
set CONTAINER_NAME=event-platform
set PORT=3000

echo ================================
echo Event Ticket Platform - Docker
echo ================================
echo.

if "%1"=="build" (
    echo Building Docker image...
    docker build -t %IMAGE_NAME% .
    echo.
    echo Build complete! Run 'docker-run.bat start' to start the application.
    goto :end
)

if "%1"=="start" (
    echo Starting container...
    docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
    echo.
    echo Application started!
    echo Access it at: http://localhost:%PORT%
    echo.
    echo To view logs: docker-run.bat logs
    echo To stop: docker-run.bat stop
    goto :end
)

if "%1"=="stop" (
    echo Stopping container...
    docker stop %CONTAINER_NAME%
    echo Container stopped.
    goto :end
)

if "%1"=="remove" (
    echo Removing container...
    docker rm %CONTAINER_NAME%
    echo Container removed.
    goto :end
)

if "%1"=="logs" (
    echo Showing logs (Ctrl+C to exit)...
    docker logs -f %CONTAINER_NAME%
    goto :end
)

if "%1"=="restart" (
    echo Restarting...
    docker stop %CONTAINER_NAME%
    docker rm %CONTAINER_NAME%
    docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
    echo Application restarted!
    echo Access it at: http://localhost:%PORT%
    goto :end
)

if "%1"=="rebuild" (
    echo Rebuilding and restarting...
    docker stop %CONTAINER_NAME% 2>nul
    docker rm %CONTAINER_NAME% 2>nul
    docker build -t %IMAGE_NAME% .
    docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
    echo Application rebuilt and restarted!
    echo Access it at: http://localhost:%PORT%
    goto :end
)

if "%1"=="clean" (
    echo Cleaning up...
    docker stop %CONTAINER_NAME% 2>nul
    docker rm %CONTAINER_NAME% 2>nul
    docker rmi %IMAGE_NAME% 2>nul
    echo Cleanup complete.
    goto :end
)

echo Usage: docker-run.bat [command]
echo.
echo Commands:
echo   build     - Build the Docker image
echo   start     - Start the container
echo   stop      - Stop the container
echo   restart   - Restart the container
echo   rebuild   - Rebuild image and restart container
echo   remove    - Remove the container
echo   logs      - View container logs
echo   clean     - Remove container and image
echo.
echo Quick start:
echo   1. docker-run.bat build
echo   2. docker-run.bat start
echo   3. Open http://localhost:%PORT%

:end
endlocal
