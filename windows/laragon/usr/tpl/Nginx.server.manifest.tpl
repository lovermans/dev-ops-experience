server {
	listen <<PORT>>;
    server_name <<HOSTNAME>> *.<<HOSTNAME>>;
    root "<<PROJECT_DIR>>";
    
    index index.html index.htm index.php;
 
    location ~* (.+)(\.)(css|js|webp|jpg|png|ico|svg|woff2)(.*) {
		try_files $1$2$3 /index.php$is_args$args;
        expires 360d;
		add_header Cache-Control public;
        add_header Pragma public;
        add_header Vary Accept-Encoding;
    }
	
    #websocket connection
	location /app/ {
        proxy_pass http://127.0.0.1:6001/app/;
        proxy_read_timeout     60;
        proxy_connect_timeout  60;
        proxy_redirect         off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
		proxy_cache_bypass $http_upgrade;
    }
    
    location /apps/ {
        proxy_pass http://127.0.0.1:6001/apps/;
        proxy_set_header Host $host;
    }
	
	location / {
        try_files $uri $uri/ /index.php$is_args$args;
		autoindex on;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass php_upstream;
        #fastcgi_pass octane_roadrunner_fcgi;
        #fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		fastcgi_keep_conn on;
    }
	
    charset utf-8;
	
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    location ~ /\.ht {
        deny all;
    }
}

# This file is auto-generated.
# If you want Laragon to respect your changes, just remove the [auto.] prefix
# If you want to use SSL, enable it at: Menu > Nginx > SSL > Enabled