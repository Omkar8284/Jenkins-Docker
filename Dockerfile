FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
 CMD wget -qO- http://localhost:80 || exit 1
