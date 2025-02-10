#!/bin/bash
docker stop my-httpd-container 2>/dev/null || true
docker rm my-httpd-container 2>/dev/null || true
docker rmi my-httpd 2>/dev/null || true
docker build --platform linux/amd64 -t my-httpd .
docker run -d -p 8080:8080 --name my-httpd-container my-httpd
docker ps
docker logs my-httpd-container
