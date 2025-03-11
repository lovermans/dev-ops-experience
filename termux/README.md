> [!NOTE]  
> - Tested On Android 14 Infinix Hot 50 Pro (No Root) with auto battery optimization disabled for termux app.
> - "Disable child process restrictions" option in Developer Option Menu is enabled (toggle to On).
> - Proot Distro using Ubuntu 24.04 LTS.

- [Disable Phantom Process Killer on Android 12 or 13](#disable-phantom-process-killer-on-android-12-or-13)
  - [Instal Android Tools](#instal-android-tools)
  - [Turn On Developer Option and Wireless Debugging](#turn-on-developer-option-and-wireless-debugging)
    - [Pair Device](#pair-device)
    - [Connect Device](#connect-device)
    - [Disable Phantom Process Killer](#disable-phantom-process-killer)
- [Disable Phantom Process Killer on Android 14](#disable-phantom-process-killer-on-android-14)
- [Setup Proot Distro Ubuntu](#setup-proot-distro-ubuntu)
  - [Keep Termux Running in Background](#keep-termux-running-in-background)
  - [Termux Storage Permission Acces](#termux-storage-permission-acces)
  - [Instal Proot Distro Ubuntu](#instal-proot-distro-ubuntu)
  - [Basic User Setup Ubuntu](#basic-user-setup-ubuntu)
  - [Change Timezone](#change-timezone)
  - [Install Ubuntu Desktop Environment (for remote VNC or Windows Remote Desktop)](#install-ubuntu-desktop-environment-for-remote-vnc-or-windows-remote-desktop)
    - [XFCE Desktop Environtment (lightweight \& highly customable)](#xfce-desktop-environtment-lightweight--highly-customable)
    - [GNOME Desktop Environment (modern, more feature but heavy on low resource device)](#gnome-desktop-environment-modern-more-feature-but-heavy-on-low-resource-device)
  - [Fix Audio Proot Distro Ubuntu](#fix-audio-proot-distro-ubuntu)
  - [Desktop Environmet Hardware Acceleration (Mali GPU)](#desktop-environmet-hardware-acceleration-mali-gpu)
  - [Install Chromium Web Browser](#install-chromium-web-browser)
- [Setup PHP in Proot Distro Ubuntu](#setup-php-in-proot-distro-ubuntu)
- [Setup Composer in Proot Distro Ubuntu](#setup-composer-in-proot-distro-ubuntu)
- [Setup NVM in Proot Distro Ubuntu](#setup-nvm-in-proot-distro-ubuntu)
- [Setup NodeJS and NPM in Proot Distro Ubuntu](#setup-nodejs-and-npm-in-proot-distro-ubuntu)
- [Setup Nginx in Proot Distro Ubuntu](#setup-nginx-in-proot-distro-ubuntu)
- [Setup MariaDB in Proot Distro Ubuntu](#setup-mariadb-in-proot-distro-ubuntu)
- [Setup VSCode in Proot Distro Ubuntu](#setup-vscode-in-proot-distro-ubuntu)

# Disable Phantom Process Killer on Android 12 or 13
## Instal Android Tools
```sh
pkg update && pkg upgrade && pkg install android-tools
```

## Turn On Developer Option and Wireless Debugging
### Pair Device
```sh
adb pair ip:pairing_port paring_code
```

### Connect Device
```sh
adb connect ip:adb_port
```

### Disable Phantom Process Killer
```sh
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
```
```sh
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
```
```sh
adb shell settings put global settings_enable_monitor_phantom_procs false
```

Then disable all default and/or vendor auto battery optimization settings for termux app.

# Disable Phantom Process Killer on Android 14
- Go to Developer Option Menu.
- Find "Disable child process restrictions" and toggle it on.

Then disable all default and/or vendor battery optimization settings for termux app.

# Setup Proot Distro Ubuntu
## Keep Termux Running in Background
```sh
termux-wake-lock
```

## Termux Storage Permission Acces
```sh
termux-setup-storage
```


If you prefer execute commands via remote SSH 

- Package To Create User Password
```sh
pkg install termux-auth
```

- Create User Password
```sh
passwd
```

- Install Open SSH Server And NMap Package
```sh
pkg install openssh && pkg install nmap
```

- Start SSH Server
```sh
sshd
```

- Check SSH Open Port
```sh
nmap -sV localhost
```

- Check Local IP (Find Wlan Inet)
```sh
ifconfig
```

- Check Your Username
```sh
whoami
```

- SSH Login from other device
```sh
ssh your_android_username@your_local_ip -p you_SSH_port
```

## Instal Proot Distro Ubuntu
- Install Proot Package
```sh
pkg install proot-distro
```

- Install Proot Distro Ubuntu
```sh
proot-distro install ubuntu
```

## Basic User Setup Ubuntu
- Login Ubuntu
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp
```

- Update & Upgrade Ubuntu Package
```sh
apt update && apt upgrade
```

- Add Password to Root User
```sh
passwd
```

- Install Packages to Manage Users
```sh
apt install sudo nano adduser
```

- Add New User 
```sh
adduser yournewusername
```

- Open User Setting 
```sh
nano /etc/sudoers
```

- Edit User Setting 
```diff
# User privilege specification
root    ALL=(ALL:ALL) ALL
+ yournewusername ALL=(ALL:ALL) ALL
```
Save and exit nano text editor : <kbd>Ctrl</kbd>+<kbd>X</kbd> and press <kbd>Y</kbd> then <kbd>Enter</kbd>.

- Exit Ubuntu
```sh
exit
```

- Login Ubuntu As New Created User
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername
``` 

## Change Timezone
```sh
sudo dpkg-reconfigure tzdata
```
Choose Your Timezone Region

## Install Ubuntu Desktop Environment (for remote VNC or Windows Remote Desktop)
### XFCE Desktop Environtment (lightweight & highly customable)
- Install XFCE Desktop Environtment (suitable for low resources devices)
```sh
sudo apt install xfce4 xfce4-goodies tigervnc-standalone-server firefox dbus-x11
```

- Start VNC Server
```sh
vncserver -xstartup startxfce4 -geometry 1624x720 -autokill -localhost no -nolisten tcp :1
```

- Stop VNC Server
```sh
vncserver -kill :1
```

- Install XRDP For Using With Windows Remote Desktop
```sh
sudo apt install xrdp
```

- Start XRDP Service if it is not started
```sh
sudo service xrdp restart
```
- Start Windows XRDP and Connect to localhost or your local IP.
- Choose Session : vnc-any.
- Fill your IP/localhost, port VNC Server running port above (default :5901) and your VNC Password.
- Or you could edit XRDP default setting in /etc/xrdp/xrdp.ini

### GNOME Desktop Environment (modern, more feature but heavy on low resource device)
- Login Ubuntu with Root access
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp
```

- Install Package
```sh
apt install gnome-shell gnome-terminal gnome-tweaks gnome-shell-extensions gnome-shell-extension-ubuntu-dock nautilus gedit
```

- Install Theme
```sh
apt install yaru-theme-gtk yaru-theme-icon
```

- Create Xstartup File
```sh
nano .vnc/xstartup
```
- Write Xstartup File Content
``` 
#!/bin/bash

export XDG_CURRENT_DESKTOP="GNOME"
service dbus start
gnome-shell --x11
```
Save and exit nano text editor : <kbd>Ctrl</kbd>+<kbd>X</kbd> and press <kbd>Y</kbd> then <kbd>Enter</kbd>.

- Make Xstartup File Executable
```sh 
chmod +x ~/.vnc/xstartup
```

- Fix Systemd Gnome Issue (execute command every time before starting VNC if there is an error or blank screen)
```sh
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file 
done
```
Then exit and relogin to root (superuser) access

- Start VNC
```sh
vncserver -autokill -localhost no -nolisten tcp :1
```

## Fix Audio Proot Distro Ubuntu
- Exit Proot Distro, Back to Termux and Install Pulseaudio
```sh
pkg install pulseaudio
```

- Start Pulseaudio in Termux
```sh
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
```

- Login to Proot Distro Ubuntu
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername
```

- Connect Pulse Audio
```sh
export PULSE_SERVER=127.0.0.1
```

- Start VNC Server
```sh
vncserver -xstartup startxfce4 -autokill -localhost no -nolisten tcp :1
```

## Desktop Environmet Hardware Acceleration (Mali GPU)
- Exit Proot Distro, Back to Termux and Install Following Package
```sh
pkg install tur-repo; pkg install x11-repo; pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android virglrenderer-android
```

- Start Grapical Server in Termux
```sh
virgl_test_server_android
```

- Open New Termux Session And Login To Ubuntu
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername
```

- Start VNC Server With Hardware Aceleration
```sh
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 vncserver -xstartup startxfce4 -autokill -localhost no -nolisten tcp :1
```

## Install Chromium Web Browser
- Add Repository
```sh
sudo add-apt-repository ppa:xtradeb/apps
```

- Update Repository
```sh
sudo apt update
```

- Install Chromium
```sh
sudo apt install chromium
```

- Open Chromium Web Broser
```sh
chromium --no-sandbox
```

- Make Chromium as Default Browser in XFCE Desktop Environment
> Settings -> Default Applications -> Internet -> Web Browser -> Other
> Select "chromium" and add "--no-sandbox" on the command line

# Setup PHP in Proot Distro Ubuntu
- Add Latest PHP Repository
```sh
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
```

- Add apt-utils Package
```sh
sudo apt install apt-utils
```

- Update & Upgrade Package
```sh
sudo apt update && apt upgrade
```

- Remove Old Package (if exists)
```sh
sudo apt autoremove
```

- Install PHP CLI & PHP FPM
```sh
sudo apt install php8.4-cli php8.4-fpm
```

- Check PHP Installation
```sh
php -v
```

# Setup Composer in Proot Distro Ubuntu
- Download Composer
```sh
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

- Enable Composer Globally
```sh
sudo mv composer.phar /usr/local/bin/composer
```

- Check Composer Installation
```sh
composer
```

# Setup NVM in Proot Distro Ubuntu
- Download NVM
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

- Close and Reopen Terminal then Check NVM Installation 
```sh
nvm
```

# Setup NodeJS and NPM in Proot Distro Ubuntu
- Download NodeJS and NPM via NVM
```sh
nvm install --lts
```

- Choose NodeJS version to use via NVM
```sh
nvm use --lts
```

- Check NodeJS Installation 
```sh
node -v
```

- Check NPM Installation 
```sh
npm -v
```

# Setup Nginx in Proot Distro Ubuntu
- Add Nginx Repository
```sh
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx
```

- Install Nginx With All Modules Available
```sh
sudo apt install nginx-extra
```

- Check Nginx Installation 
```sh
nginx -v
```

- Run Nginx Server 
```sh
sudo service nginx start
```
You could also put following service commands : stop, restart, reload, force-reload, status, configtest, rotate, upgrade.

# Setup MariaDB in Proot Distro Ubuntu
- Add MariaDB Repository
```sh
sudo apt-get install apt-transport-https curl
```
```sh
sudo mkdir -p /etc/apt/keyrings
```
```sh
sudo curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'
```
```sh
sudo nano /etc/apt/sources.list.d/mariadb.sources
```
Copy and paste script bellow
```
# MariaDB 11.8 repository list - created 2025-03-08 06:52 UTC
# https://mariadb.org/download/
X-Repolib-Name: MariaDB
Types: deb
# deb.mariadb.org is a dynamic mirror if your preferred mirror goes offline. See https://mariadb.org/mirrorbits/ for details.
# URIs: https://deb.mariadb.org/11.rc/ubuntu
URIs: https://mirror.citrahost.com/mariadb/repo/11.8/ubuntu
Suites: noble
Components: main main/debug
Signed-By: /etc/apt/keyrings/mariadb-keyring.pgp
```
Save and exit nano text editor : <kbd>Ctrl</kbd>+<kbd>X</kbd> and press <kbd>Y</kbd> then <kbd>Enter</kbd>.

- Install MariaDB 
```sh
sudo apt update
```
```sh
sudo apt install mariadb-server
```

- Check MariaDB Installation 
```sh
mariadb --version
```

- Run MariaDB Server 
```sh
sudo service mariadb start
```
You could also put following service commands : stop, restart, reload, force-reload, status.

- Secure MariaDB Server Setup
```sh
sudo mariadb-secure-installation
```

- Login MariaDB
```sh
sudo mariadb -u root -p
```

- List All MariaDB User 
```sh
SELECT user, host, password, plugin from mysql.user;
```

- Logout MariaDB
```sh
exit
```

# Setup VSCode in Proot Distro Ubuntu
- Add Repository
```sh
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
```

- Install VSCode
```sh
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```

- Open VSCode
```sh
code --no-sandbox
```
