FROM nginx:alpine

# Remove default config and replace with yours
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d/

# Copy built frontend files
COPY dist/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
