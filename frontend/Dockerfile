FROM nginx:alpine

# Install Python (for OOM simulation script)
RUN apk add --no-cache python3

# Remove default config and replace with ours
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d/

# Copy built static files
COPY dist/ /usr/share/nginx/html/

# Copy and enable the crash script
COPY oom-crash.sh /oom-crash.sh
RUN chmod +x /oom-crash.sh

EXPOSE 80

# Instead of running NGINX, run the crash script to simulate failure
CMD ["/oom-crash.sh"]
