FROM ubuntu:20.04

# Install vsftpd and nginx
RUN apt-get update && \
    apt-get install -y supervisor nginx && \
    rm -rf /var/lib/apt/lists/*

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY html /var/www/html
RUN chmod -R 755 /var/www/html

# Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod -R 755 /etc/supervisor/conf.d/supervisord.conf

# Expose HTTP ports
EXPOSE 8080

# Start Supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]