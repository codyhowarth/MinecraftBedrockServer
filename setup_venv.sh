#!/bin/bash

sudo apt install python3-venv
python3 -m venv /home/cody/virtualenvironment/discord_scripts
source /home/cody/virtualenvironment/discord_scripts/bin/activate
pip install -r /home/cody/MinecraftBedrockServer/requirements.txt
deactivate

# copy over the scripts

read -p 'Please enter the discord webhook url so the script may post updates: ' webhookUrl

sed -i "s!<webhook url goes here>!$webhookUrl!g" /home/cody/MinecraftBedrockServer/server_off_msg.py
sed -i "s!<webhook url goes here>!$webhookUrl!g" /home/cody/MinecraftBedrockServer/server_on_msg.py
cp /home/cody/MinecraftBedrockServer/server_off_msg.py /home/cody
cp /home/cody/MinecraftBedrockServer/server_on_msg.py /home/cody