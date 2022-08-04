timeout 100 ssh -i ~/butterjam.pem ubuntu@52.66.45.141 "mkdir -p /var/www/mysite/52.66.45.141"

echo "directory created"

timeout 200 ssh -t -i ~/butterjam.pem ubuntu@52.66.45.141 <<EOF
echo "installing php" 
sudo apt install php -y

echo "depandance packages"
sudo apt install php-mysql php-gd php-common php-mbstring php-curl php cli -y

sudo apt install php-fpm -y

sudo systemctl enable php-fpm

sudo systemctl restart php-fpm


#Downloading wordpress website 

wget wordpress.org/latest.tar.gz

# Extracting the zip file

tar xvf latest.tar.gz

echo"extaracting files"

#moving wordpress to mysite
sudo mv wordpress /var/www/mysite

cd /var/www/mysite.computingforgeeks.com
sudo cp wp-config-sample.php wp-config.php

sudo touch /etc/nginx/sites-available/52.66.45.141

  #tee is used to write output to the file
  
sudo tee  /etc/nginx/sites-available/52.66.45.141 <<'eof'                      


server {
	listen			3001;
	server_name		52.66.45.141;
	root			/var/www/mysite/52.66.45.141;
	index			index.php;
    location / {
		try_files $uri $uri/ /index.php$is_args$args;
		}
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1.2-fpm.sock;
  }
  location ~ /\.ht {
    deny all;
  }
}

eof

sudo ln -s -f /etc/nginx/sites-available/52.66.45.141  /etc/nginx/sites-enabled/wordpress.conf 

sudo nginx -t

sudo systemctl restart nginx

echo "Successfully configured nginx server"

EOF