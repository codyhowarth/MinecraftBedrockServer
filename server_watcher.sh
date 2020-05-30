#!/bin/bash

# Answer from: https://askubuntu.com/questions/157779/how-to-determine-whether-a-process-is-running-or-not-and-make-use-it-to-make-a-c/988986#988986

# Check if a process is alive and running
_isRunning() {
    ps -o comm= -C "$1" 2>/dev/null | grep -x "$1" >/dev/null 2>&1
}

# reboot the machine if the server crashes
if ! _isRunning bedrock; then
    sudo shutdown -r now
fi