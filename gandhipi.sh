#!/bin/bash
sudo apt-get update -y 
echo "Aktualisiert"
sudo apt-get upgrade -y 
echo "Auf neuste Versionen gewechselt"
sudo apt-get install -y samba ufw fish bat btop neofetch git neovim 
echo "samba, ufw, git, neovim, fish und bat installiert"
sudo chsh -s /usr/bin/fish
sudo chsh -s /usr/bin/fish $(whoami)
echo "fish als default shell ausgewählt" 
curl -sSL https://get.docker.com | sh 
echo "docker installiert"
sudo usermod -aG docker $USER 
echo "User zur dockergruppe hinzugefügt "
mkdir $HOME/.config/dockercfg 
echo "docker config Ordner erstellt"
docker run -d \
  --name homeassistant \
  --privileged \
  --restart=unless-stopped \
  -e TZ=MY_TIME_ZONE \
  -v /home/nrdrch/.config/dockercfg:/config \
  -v /run/dbus:/run/dbus:ro \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable 
echo "home assistant installiert"
mkdir $HOME/.ssh
echo ".ssh Ordner erstellt"
mkdir $HOME/Scripts
echo "Scripts Ordner erstellt"
curl https://pyenv.run | bash 
echo "pyenv Installiert"
sudo ufw allow ssh 
sudo ufw allow 8123 
sudo ufw allow 4002 
sudo ufw allow 445/tcp 
sudo ufw enable 
echo "set up ufw"
# Fish commands
/usr/bin/fish << EOF
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
alias --save bat=batcat
alias --save c=clear
alias --save e=exit
alias --save cfg="cd $HOME/.config"
alias --save ctl="sudo systemctl"
alias --save docs="cd $HOME/Documents"
alias --save downs="cd $HOME/Downloads"
alias --save musicbot="bash $HOME/Scripts/runmb.sh"
alias --save get="sudo apt-get install -y"
alias --save gettemp="vcgencmd measure_temp"
alias --save dockercfg="cd $HOME/.config/dockercfg"
EOF






