FROM node:6-slim
# Working directory for application
WORKDIR /var/www/node
# Binds to port 7777
EXPOSE 7777
# Creates a mount point
VOLUME [ "/var/www/node" ]