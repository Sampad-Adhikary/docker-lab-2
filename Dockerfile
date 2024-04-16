# This line specifies the base image for the Docker container. In this case, it is using the "ubuntu:20.04" image
FROM ubuntu:20.04

# Step 1: Install supervisor and nginx
# Update the package lists and install supervisor and nginx
RUN apt-get update && \
    apt-get install -y supervisor nginx && \
    rm -rf /var/lib/apt/lists/*

# Step 2: Configure Nginx
# Copy the nginx configuration file to the appropriate location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the frontend files to the web server's document root
COPY frontend /var/www/frontend

# Set the appropriate permissions for the frontend files
RUN chmod -R 755 /var/www/frontend

# Step 3: Configure Supervisor
# Copy the supervisor configuration file to the appropriate location
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set the appropriate permissions for the supervisor configuration file
RUN chmod -R 755 /etc/supervisor/conf.d/supervisord.conf

# Step 4: Expose HTTP ports
# Expose port 8080 to allow incoming HTTP traffic
EXPOSE 8080

# Step 5: Start Supervisor
# Start the supervisor process with the specified configuration file
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]