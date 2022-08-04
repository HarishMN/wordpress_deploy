timeout 100 ssh -i ~/butterjam.pem ubuntu@52.66.45.141 "mkdir -p /var/www/mysite/52.66.45.141"

echo "directory created"

timeout 200 ssh -t -i ~/butterjam.pem ubuntu@52.66.45.141 <<EOF

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


echo "installing php" 
sudo apt install php -y

echo "depandance packages"
sudo apt install php-mysql php-gd php-common php-mbstring php-curl php cli -y

sudo apt install php-fpm -y


#Downloading wordpress website 

wget http://wordpress.org/latest.zip

#installing unzip
sudo apt install unzip -y
echo "unzip installed"

#Extracting the zip file

unzip latest.zip 

echo "unzipping done"

#moving wordpress  file to

sudo mv wordpress/* /var/www/mysite  -y

#removing default file

#sudo rm /etc/nginx/sites-enabled/default

sudo touch /etc/nginx/sites-enabled/wordpress.conf 

sudo chmod 666 /etc/nginx/sites-enabled/wordpress.conf

sudo ln -s -f /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/wordpress.conf  -y

sudo nginx -t

sudo systemctl restart nginx

echo "Successfully configured nginx server"

EOF