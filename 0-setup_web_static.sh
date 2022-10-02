#!/usr/bin/env bash
# setup server for AriBnB_clone projet deployement

# install nginx if not already installed
if [[ ! -f "/etc/init.d/nginx" ]]; then
	sudo apt install -y nginx
fi

# create deployment folders
sudo mkdir -p "/data/web_static/shared"
sudo mkdir -p "/data/web_static/releases/test"

# create fake html file
echo "Hello World!" | sudo tee "/data/web_static/releases/test/index.html" 

# re-create symbol link
sudo ln -sf "/data/web_static/releases/test" "/data/web_static/current"

# update /data ownership
sudo chown -R ubuntu:ubuntu "/data"

# update nginx configuration

sudo sed -i \
	"s/^}$/\tlocation \/hbtn_static \{\n\t\talias \/data\/web_static\/current\/;\n\t\tautoindex off;\n\t\}\n\}/" \
	/etc/nginx/sites-available/default

# enable default site
sudo ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

