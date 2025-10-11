server {
    listen <<PORT>>;
    listen [::]:<<PORT>>;

    listen <<SSL_PORT>> ssl;
    listen [::]:<<SSL_PORT>> ssl;

    http2 on;
    server_name <<HOSTNAME>> *.<<HOSTNAME>>;
    root "<<PROJECT_DIR>>";

    index index.html index.htm index.php;

    # [START--> remove index.php from url]
    if ($request_uri ~* "^(.*/)index\.php/*(.*)" ) {
        return 301 $1$2;
    }
    # [END--> remove index.php from url]

    # [START--> cache static assets]
    location ~* (.+)(\.)(css|js|webp|jpg|png|ico|svg|woff2)(.*) {
        # # [START--> prevent hotlinking]
        # valid_referers server_names;
        # if ($invalid_referer) {
        # 	return 404;
        # }
        # # [END--> prevent hotlinking]
        try_files $1$2$3 /index.php$is_args$args;
        expires 360d;
        add_header Cache-Control public;
        add_header Pragma public;
        add_header Vary Accept-Encoding;
    }
    # [END--> cache static assets]

    # # [START--> websocket connection]
    # location /app/ {
    # 	proxy_pass http://127.0.0.1:6001/app/;
    # 	proxy_read_timeout 60;
    # 	proxy_connect_timeout 60;
    # 	proxy_redirect off;
    # 	proxy_http_version 1.1;
    # 	proxy_set_header Upgrade $http_upgrade;
    # 	proxy_set_header Connection "Upgrade";
    # 	proxy_set_header Host $host;
    # 	proxy_cache_bypass $http_upgrade;
    # }

    # location /apps/ {
    # 	proxy_pass http://127.0.0.1:6001/apps/;
    # 	proxy_set_header Host $host;
    # }
    # # [END--> websocket connection]

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
        autoindex on;
    }

    location ~ \.php$ {
        # [START--> process php app using fastcgi]
        include snippets/fastcgi-php.conf;
        fastcgi_pass php_upstream; # default laragon php fastcgi
        # fastcgi_pass octane_roadrunner_fcgi; # use roadrunner fastcgi mode
        # fastcgi_pass unix:/run/php/php8.4-fpm.sock; # use php-fpm unix socket
        fastcgi_keep_conn on;
        # [END--> process php app using fastcgi]

        # # [START--> process php app using reverse proxy]
        # proxy_http_version 1.1;
        # proxy_set_header Host $host;
        # proxy_set_header Scheme $scheme;
        # proxy_set_header SERVER_PORT $server_port;
        # proxy_set_header REMOTE_ADDR $remote_addr;
        # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        # proxy_set_header X-Forwarded-Port $server_port;
        # proxy_set_header X-Forwarded-Host $host;
        # proxy_set_header X-Forwarded-Proto $scheme;
        # proxy_set_header Connection "keep-alive";
        # proxy_set_header Proxy "";
        # proxy_pass http://127.0.0.1:8000$request_uri; # proxy server address
        # # [END--> process php app using reverse proxy]
    }

    ssl_certificate "<<SSL_DIR>>/<<HOSTNAME>>.crt";
    ssl_certificate_key "<<SSL_DIR>>/<<HOSTNAME>>.key";
    ssl_session_timeout 5m;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    charset utf-8;

    location = /favicon.ico {
        access_log off;
        log_not_found off;
    }

    location = /robots.txt {
        access_log off;
        log_not_found off;
    }

    location ~ /\.ht {
        deny all;
    }
}

# This file is auto-generated.
# If you want Laragon to respect your changes, just remove the [auto.] prefix