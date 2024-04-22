# gandhihelper
gandhihelper
Home assistant Installation
```
docker run -d \
  --name homeassistant \
  --privileged \
  --restart=unless-stopped \
  -e TZ=MY_TIME_ZONE \
  -v /home/gandhi/.config/dockercfg:/config \
  -v /run/dbus:/run/dbus:ro \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable \ > /dev/null
```
#######################################
#  Samba konfigurierung
```
sudo nvim /etc/samba/smb.conf
```
```
[MUSIC_BOT_CONFIG]
   path = /home/gandhi/MusicBot/config
   read only = no
   guest ok = yes
   browseable = yes
[HOMEASSISTANT_CONFIG]
   path = /home/gandhi/.config/dockershit
   read only = no
   guest ok = yes
   browseable = yes
[SCRIPTS]
   path = /home/gandhi/Scripts
   read only = no
   guest ok = yes
   browseable = yes
```
```
sudo smbpasswd -a gandhi
```
```
sudo systemctl start smbd
sudo systemctl restart smbd
```
#######################################
# ufw configuration

#######################################
# Windows:
function remount {
    $null = net use X: /delete 2>&1
    $null = net use Y: /delete 2>&1
    $null = net use Z: /delete 2>&1
    $null = net use X: \\gandhi\MUSIC_BOT_CONFIG /user:gandhi PASSWORD
    $null = net use Z: \\gandhi\HOMEASSISTANT_CONFIG /user:gandhi PASSWORD
    $null = net use Y: \\gandhi\SCRIPTS /user:gandhi PASSWORD

    if (-not ($Error)) {
        Write-Host "All commands completed successfully."
    }
}
