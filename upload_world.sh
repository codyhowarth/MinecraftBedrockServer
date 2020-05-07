#!/bin/bash

sshpass -p 'XXX' rsync -uv --stats --progress /mnt/d/minecraft_server/server.properties cody@172.81.179.29:/home/cody/minecraftbe/cnk/
sshpass -p 'XXX' rsync -ruv --stats --progress /mnt/d/minecraft_server/worlds/Castle\ Max\ Chillax/ cody@172.81.179.29:/home/cody/minecraftbe/cnk/worlds