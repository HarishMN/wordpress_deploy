timeout 100 ssh -i ~/onekingharry.pem ubuntu@65.1.64.90 "mkdir -p /var/www/wordpress/"

echo "directory created"

timeout 200 ssh -t -i ~/onekingharry.pem ubuntu@65.1.64.90 <<EOF

sudo apt install nginx -y
echo"installed nginx"

sudo systemctl start nginx

sudo systemctl enable nginx
EOF