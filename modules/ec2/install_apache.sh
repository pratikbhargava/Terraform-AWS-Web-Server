#! /bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y apache2
sudo apache2ctl -v
sudo systemctl start apache2.service
sudo systemctl enable apache2.service
echo "<h1>Test Web Server Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
