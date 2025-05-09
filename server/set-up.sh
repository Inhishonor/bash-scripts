# A bash script used for setting up a server on debian/ubuntu. WIP
# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install Tools
sudo apt install smartmontools -y
sudo apt install nano -y
sudo apt install ufw -y
sudo apt install scp -y

#Install OpenVPN client
echo "Would you like to install and configure an open vpn client? [y/n]"
read vpnanswer
if [ "$vpnanswer" = "y" ]; then
  sudo apt install openvpn -y
  echo "Please copy the contents of the client.conf file, from the open VPN server."
  sudo nano /etc/openvpn/client.conf 
  echo "Next, the script is going to test if the VPN works. The terminal will lock into execution, while it is verify the connection at the OpenVPN server. Then return here, and use ctrl + c, to stop the process and this script."
  sudo openvpn --config /etc/openvpn/client.conf 
else
  echo "That's it!"
fi
  

