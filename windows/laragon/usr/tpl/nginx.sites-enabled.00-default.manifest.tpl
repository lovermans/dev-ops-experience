server {
    listen <<PORT>> default_server;
    server_name localhost ;
    root "<<DOC_ROOT>>";
    
    index index.html index.htm index.php;

    # Access Restrictions
    allow       all;
    #deny        all;
 
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
	
    charset utf-8;
	
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    location ~ /\.ht {
        deny all;
    }
}