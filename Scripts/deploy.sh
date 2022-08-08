timeout 100 ssh -i ~/onekingharry.pem ubuntu@65.1.64.90 "mkdir -p /var/www/wordpress/"

echo "directory created"

timeout 200 ssh -t -i ~/onekingharry.pem ubuntu@65.1.64.90 <<EOF

echo "sudo apt install nginx -y"
echo "installed nginx"

sudo systemctl start nginx

sudo systemctl enable nginx

echo "sudo apt install mariadb-server -y"

sudo  systemctl start mariadb
sudo  systemctl enable mariadb

echo "sudo apy install php -y"

echo "sudo apt install php-mysql php-gd php-common php-mbstring php-curl php-cli -y"
sudo systemctl restart nginx

echo "sudo apt install php-fpm -y"

 wget -c http://wordpress.org/latest.tar.gz

 echo "downloaded wordpress file"  
 
 tar -xzvf latest.tar.gz
 echo "unziping tar file"


 sudo rsync -av wordpress/* /var/www/html/
 echo "synced  wordpress  to html"

 sudo chown -R www-data:www-data /var/www/html/  
 chmod -R 755 /var/www/html/    

cd /var/www/html
echo"in the folder"
EOF