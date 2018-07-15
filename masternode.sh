#!/bin/sh
set -e

install_docker() {
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sh /tmp/get-docker.sh
  sudo usermod -aG docker $USER
  echo "... Log out and log back so that your group membership is re-evaluated!"
}

install_dependencies() {
  echo "Installing dependencies ..."
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install -y jq curl ufw fail2ban
}

setup_security() {
  # disable ssh root login
  sed -i 's|[#]*ChallengeResponseAuthentication yes|ChallengeResponseAuthentication no|g' /etc/ssh/sshd_config
  sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
  service ssh restart

  # firewall
  ufw allow ssh/tcp comment "SSH"
  ufw limit ssh/tcp
  ufw allow 8255/tcp 
  ufw logging on
  echo 'y' | ufw enable

  # dos
  systemctl enable fail2ban
  systemctl start fail2ban
}

install_dependencies
install_docker
setup_security

echo "✔ All done"