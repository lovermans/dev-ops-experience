worker_processes auto;
worker_rlimit_nofile 2048;

events {
    worker_connections 1024;
}

http {
    default_type application/octet-stream;
    include mime.types;
    server_tokens off;
    access_log off;

    sendfile on;
    tcp_nopush on;

    keepalive_requests 100000;
    keepalive_timeout 65;

    ssi on;

    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 5;
    gzip_min_length 100;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types application/atom+xml application/javascript application/json application/rss+xml application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype font/woff2 image/jpeg image/png image/webp image/svg+xml image/x-icon text/css text/plain text/x-component video/webm;

    types_hash_max_size 2048;
    client_max_body_size 2000m;
    server_names_hash_bucket_size 128;
    client_body_buffer_size 16K;
    client_header_buffer_size 1k;
    large_client_header_buffers 2 1k;
    client_body_timeout 12;
    client_header_timeout 12;
    send_timeout 10;

    include "<<LARAGON_ROOT>>/etc/nginx/*.conf";
    include "<<LARAGON_ROOT>>/etc/nginx/sites-enabled/*.conf";
}