timeout 100 ssh -i ~/onekingharry.pem ubuntu@65.1.64.90 "mkdir -p /var/www/wordpress/"

echo "directory created"

timeout 200 ssh -t -i ~/onekingharry.pem ubuntu@65.1.64.90 <<EOF

echo "sudo apt install nginx -y"
echo"installed nginx"

sudo systemctl start nginx

sudo systemctl enable nginx

sudo apt install mariadb-server -y

sudo  systemctl start mariadb
sudo systemctl enable mariadb

sudo apy install php -y

sudo apt install php-mysql php-gd php-common php-mbstring php-curl php-cli -y
sudo systemctl restart nginx

sudo apt install php-fpm -y
EOF