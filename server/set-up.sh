# A bash script used for setting up a server on debian/ubuntu. WIP
# To run on linux: sudo bash -c 'wget -O - https://raw.githubusercontent.com/Inhishonor/bash-scripts/refs/heads/main/server/set-up.sh | bash'
# Update the system
echo "Updating System"
apt update -y
apt upgrade -y

# Install Tools
echo "Installing and Updating Tools"
apt install smartmontools -y
apt install nano -y
apt install ufw -y

#Install OpenVPN client
while getopts ":v" opt; do
  case $opt in
    v)
      echo "Installing OpenVPN client..."
      apt install -y openvpn
      echo "Please copy the contents of the client.conf file from the OpenVPN server."
      nano /etc/openvpn/client.conf 
      echo "Press enter when you have finished editing the file..."
      read
      echo "Next, the script is going to test if the VPN works. The terminal will lock into execution, while you will need to verify the connection at the OpenVPN server. Then return here, and press ctrl + c, to stop the process and this script."
      openvpn --config /etc/openvpn/client.conf || { echo "There was an error, please double check the VPN configuration, and run this script again. Press enter to exit."; read; }
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

echo "That's it!"

