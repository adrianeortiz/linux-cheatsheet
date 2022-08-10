#!/bin/bash

apt update
#apt install update
apt install -y default-jre
#apt install default-jre

java_version=$(java -version 2>&1 >/dev/null | grep "java version\|openjdk version" | awk '{print substr($3,2,2)}')

if [[ "$java_version" -ge 11 ]]
then
    echo Java version 11 or greater installed successfully
else
    echo Java installation failed
fi
