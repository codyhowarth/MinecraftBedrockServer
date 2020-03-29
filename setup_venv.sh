#!/bin/bash

sudo apt install python3-venv
python3 -m venv discord_notifications
source discord_notifications/bin/activate
pip install -r requirements.txt
deactivate

# copy over the scripts

read -p 'Please enter the discord webhook url so the script may post updates: ' webhookUrl

sed -i s/\<webhook url goes here\>/$webhookUrl/g ./server_off_msg.py
sed -i s/\<webhook url goes here\>/$webhookUrl/g ./server_on_msg.py