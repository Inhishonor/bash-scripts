# Warning, this script isn't complete yet, do not use in production!
# TODO: Add better error handling.
# See this url https://github.com/nextcloud/all-in-one#how-to-properly-reset-the-instance
#!/bin/bash
set -e
echo -e "\033[31mWarning: This script is not complete yet. Do not use it in production!\033[0m"
exec < /dev/tty
echo "Hello, this script reset's a Nextcloud AIO instance. Would you like to continue? [y/n]"
read firstanswer
exec <&-
if [ "$firstanswer" = "y" ]; then
  sudo docker stop nextcloud-aio-mastercontainer > /dev/null 2>&1
  echo "Removed Nextcloud-AIO-Mastercontainer"
  
  sudo docker stop nextcloud-aio-domaincheck > /dev/null 2>&1
  echo "Removed Nextcloud-AIO-Domaincheck"
  
  sudo docker container prune > /dev/null 2>&1
  echo "Removed Nextcloud AIO containers"
  
  sudo docker network rm nextcloud-aio > /dev/null 2>&1
  echo "Removed Nextcloud-AIO docker network"

  sudo docker volume ls --filter "dangling=true"
  exec < /dev/tty
  echo "Would you like to remove these volumes? [y/n]"
  read volumeanswer
  exec <&-
  if [ "$volumeanswer" = "y" ]; then
    echo "Removing all dangling volumes"
    sudo docker volume prune --filter all=1 > /dev/null 2>&1
    echo "All dangling volumes removed"
    sudo docker volume ls --format {{.Name}}
    echo "Are there any more volumes starting with nextcloud-aio? Please remove them manually with this command: You can do that manually with sudo docker volume rm <volume_name>"
    exec < /dev/tty
    echo "Would you like to remove all docker images? [y/n]"
    read dockeranswer
    exec <&-
    if [ "$dockeranswer" = "y" ]; then
      sudo docker image prune -a
    else
      echo "All right then."
    fi
  else
    echo "You will have to remove all volumes starting with nextcloud-aio to reset the instance. You can do that manually with sudo docker volume rm <volume_name>."
  fi

  exec < /dev/tty
  echo "Would you like to remove all docker images? [y/n]"
  read dockeranswer
  exec <&-
  if [ "$dockeranswer" = "y" ]; then
    sudo docker image prune -a
  else
    echo "Never mind then"
  fi
fi
