#!/bin/bash

function read_with_prompt {
  variable_name="$1"
  prompt="$2"
  default="${3-}"
  unset $variable_name
  while [[ ! -n ${!variable_name} ]]; do
    read -p "$prompt: " $variable_name < /dev/tty
    if [ ! -n "`which xargs`" ]; then
      declare -g $variable_name=$(echo "${!variable_name}" | xargs)
    fi
    declare -g $variable_name=$(echo "${!variable_name}" | head -n1 | awk '{print $1;}')
    if [[ -z ${!variable_name} ]] && [[ -n "$default" ]] ; then
      declare -g $variable_name=$default
    fi
    echo -n "$prompt : ${!variable_name} -- accept (y/n)?"
    read answer < /dev/tty
    if [ "$answer" == "${answer#[Yy]}" ]; then
      unset $variable_name
    else
      echo "$prompt: ${!variable_name}"
    fi
  done
}

# echo 'Please enter the path to your backup location (default) /mnt/d/minecraft_server' backupLocation
# read_with_prompt backupLocation "Backup location" "/mnt/d/minecraft_server"

# don't use a prompt
backupLocation="/mnt/d/minecraft_server"

# double check that the server is stopped on the remote (so backup isn't wonky)
sshpass -p 'XXX' ssh -tt "cody@172.81.179.29" 'echo XXX | sudo -S /home/cody/minecraftbe/cnk/stop.sh'

# Wait for server to stop somehow? before disconnecting


# mv '/mnt/d/minecraft_server/worlds/Castle\ Max\ Chillax/' '/mnt/d/minecraft_server/worlds/Castle\ Max\ ChillaxBAK/'

# Azure Server
# sshpass -p 'gnOOKt$wmW*\' scp -r "cody@52.170.39.71:/home/cody/minecraftbe/codynkyle/worlds/Castle\ Max\ Chillax/" "$backupLocation/worlds/"
# sshpass -p 'gnOOKt$wmW*\' scp "cody@52.170.39.71:/home/cody/minecraftbe/codynkyle/server.properties" $backupLocation

# Lunanode Server
echo 'Copying backup files'
sshpass -p 'XXX' rsync -ruv "cody@172.81.179.29:/home/cody/minecraftbe/cnk/worlds/" "$backupLocation/worlds/"
sshpass -p 'XXX' rsync -ruv "cody@172.81.179.29:/home/cody/minecraftbe/cnk/backups/" "$backupLocation/backups/"
sshpass -p 'XXX' rsync -uv "cody@172.81.179.29:/home/cody/minecraftbe/cnk/server.properties" $backupLocation
echo 'Copy complete'

# Remove all old backups so we don't pay for space

echo 'Removing old backup files to save space'
sshpass -p 'XXX' ssh -tt "cody@172.81.179.29" 'echo XXX | sudo -S rm -rf /home/cody/minecraftbe/cnk/backups/*'
echo 'Removal complete.'

# rm -rf '/mnt/d/minecraft_server/worlds/Castle\ Max\ ChillaxBAK/'

echo 'Shelving server'
python3 '/mnt/c/git/MinecraftBedrockServer/shelve_vm.py'
