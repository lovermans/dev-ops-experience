server {
    listen <<PORT>> default_server;
    listen <<SSL_PORT>> ssl default_server;
	http2 on;
    server_name localhost ;
    root "<<DOC_ROOT>>";
    
    index index.html index.htm index.php;
 
    # Access Restrictions
    allow       all;
    #deny        all;

    if ($request_uri ~* "^(.*/)index\.php/*(.*)") {
        return 301 $1$2;
	}
 
    include "<<LARAGON_ROOT>>/etc/nginx/alias/*.conf";

    location / {
        try_files $uri $uri/ =404;
        autoindex on;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass php_upstream;
        #fastcgi_pass octane_roadrunner_fcgi;
        #fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		fastcgi_keep_conn on;
    }
    
    ssl_certificate "<<LARAGON_ROOT>>/etc/ssl/laragon.crt";
    ssl_certificate_key "<<LARAGON_ROOT>>/etc/ssl/laragon.key";
    ssl_session_timeout 5m;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
	
    charset utf-8;
	
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    location ~ /\.ht {
        deny all;
    }
}
