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
- [Setup Self Signed SSL Certificate](#setup-self-signed-ssl-certificate)
- [Setup Wine](#setup-wine)

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
sudo apt update && sudo apt upgrade
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

- Install more PHP Extension
```sh
sudo apt install php8.4-{bcmath,curl,gd,gmp,intl,mbstring,mysql,protobuf,soap,sqlite3,xml,xsl,zip}
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

- Update & Upgrade Package
```sh
sudo apt update && sudo apt upgrade
```

- Install Nginx With All Modules Available
```sh
sudo apt install nginx-extras
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
sudo apt install apt-transport-https curl
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

# Setup Self Signed SSL Certificate
- Install ca-certificates package
```sh
sudo apt install ca-certificates
```

- Custom Self Signed SSL Working Directory
```sh
mkdir ~/certs
cd ~/certs
```

- Create local certificate authority private key
```sh
openssl genrsa -des3 -out myCA.key 2048
```
Make private key passphrase

- Create root certificate
```sh
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem
```
Enter your private key passphrase and fill issuer identity questions

- Copy root certificate to ca-certificates directory as .crt file
```sh
sudo cp ~/certs/myCA.pem /usr/local/share/ca-certificates/myCA.crt
```

- Update certificate store
```sh
sudo update-ca-certificates 
```

- Create new bash file
```sh
touch generate-ssl.sh 
```

- Open bash file
```sh
nano generate-ssl.sh 
```

- Copy and paste this command
```
######################
# Create CA-signed certs
######################

NAME=localhost.test # Use your own domain name
# Generate a private key
openssl genrsa -out $NAME.key 2048
# Create a certificate-signing request
openssl req -new -key $NAME.key -out $NAME.csr
# Create a config file for the extensions
>$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = localhost.test
DNS.3 = yourwebsite.test
DNS.4 = *.yourwebsite.test
#IP.1 = 127.0.0.1 # Optionally, add an IP address (if the connection which you have planned requires it)
EOF
# Create the signed certificate
openssl x509 -req -in $NAME.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out $NAME.crt -days 825 -sha256 -extfile $NAME.ext
```
Save and exit nano text editor : <kbd>Ctrl</kbd>+<kbd>X</kbd> and press <kbd>Y</kbd> then <kbd>Enter</kbd>.

- Make bash file executable
```sh
chmod +x generate-ssl.sh 
```

- Create self signed SSL
```sh
./generate-ssl.sh 
```

- Rename localhost.test.crt to localhost.test.pem on home/user/certs folder
- Copy localhost.test.pem above to etc/ssl/certs folder
- Copy localhost.test.key from home/user/certs folder to etc/ssl/private folder

# Setup Wine
- Login As Superuser
```sh
proot-distro login ubuntu --fix-low-ports
```

- Start VNC on display 1
```sh
vncserver -xstartup startxfce4 -geometry 1624x720 -autokill -localhost no -nolisten tcp :1
```

- Add Box86 Repo
```sh
wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg 
```

- Add Box64 Repo
```sh
wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
```

- Install Box86
```sh
dpkg --add-architecture armhf
apt update -y
apt install libc6:armhf -y
apt install box86-android:armhf -y
```

- Install Box64
```sh
apt update -y
apt install box64-android -y
```

- Install Additional Package
```sh
apt install nano cabextract libfreetype6 libfreetype6:armhf libfontconfig libfontconfig:armhf libxext6 libxext6:armhf libxinerama-dev libxinerama-dev:armhf libxxf86vm1 libxxf86vm1:armhf libxrender1 libxrender1:armhf libxcomposite1 libxcomposite1:armhf libxrandr2 libxrandr2:armhf libxi6 libxi6:armhf libxcursor1 libxcursor1:armhf libvulkan-dev libvulkan-dev:armhf zenity
```

- Install Wine
```sh
cd ~/
wget https://github.com/Kron4ek/Wine-Builds/releases/download/8.0.1/wine-8.0.1-amd64.tar.xz
wget https://github.com/Kron4ek/Wine-Builds/releases/download/8.0.1/wine-8.0.1-x86.tar.xz
tar xvf wine-8.0.1-amd64.tar.xz
tar xvf wine-8.0.1-x86.tar.xz
mv wine-8.0.1-amd64 wine64
mv wine-8.0.1-x86 wine
```

- Setup Bash
```sh
echo 'export DISPLAY=:1 #your display environment
export BOX86_PATH=~/wine/bin/
export BOX86_LD_LIBRARY_PATH=~/wine/lib/wine/i386-unix/:/lib/i386-linux-gnu/:/lib/aarch64-linux-gnu/:/lib/arm-linux-gnueabihf/:/usr/lib/aarch64-linux-gnu/:/usr/lib/arm-linux-gnueabihf/:/usr/lib/i386-linux-gnu/
export BOX64_PATH=~/wine64/bin/
export BOX64_LD_LIBRARY_PATH=~/wine64/lib/i386-unix/:~/wine64/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu:/lib/aarch64-linux-gnu/:/lib/arm-linux-gnueabihf/:/usr/lib/aarch64-linux-gnu/:/usr/lib/arm-linux-gnueabihf/:/usr/lib/i386-linux-gnu/:/usr/lib/x86_64-linux-gnu' >> ~/.bashrc

source ~/.bashrc
```

- Wine Shortcut
```sh
echo '#!/bin/bash 
export WINEPREFIX=~/.wine32
box86 '"$HOME/wine/bin/wine "'"$@"' > /usr/local/bin/wine
chmod +x /usr/local/bin/wine
echo '#!/bin/bash 
export WINEPREFIX=~/.wine64
box64 '"$HOME/wine64/bin/wine64 "'"$@"' > /usr/local/bin/wine64
chmod +x /usr/local/bin/wine64
```

- Install Winetricks
```sh
cd ~/
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv winetricks /usr/local/bin/
```

- Setup Winetricks
```sh
echo '#!/bin/bash 
export BOX86_NOBANNER=1 WINE=wine WINEPREFIX=~/.wine32 WINESERVER=~/wine/bin/wineserver
wine '"/usr/local/bin/winetricks "'"$@"' > /usr/local/bin/winetricks32
chmod +x /usr/local/bin/winetricks32
echo '#!/bin/bash 
export BOX64_NOBANNER=1 WINE=wine64 WINEPREFIX=~/.wine64 WINESERVER=~/wine64/bin/wineserver
wine64 '"/usr/local/bin/winetricks "'"$@"' > /usr/local/bin/winetricks64
chmod +x /usr/local/bin/winetricks64
```

- Wine Explorer Shotcut
```sh
cd ~/Desktop
echo '[Desktop Entry]
Name=Wine32 Explorer
Exec=bash -c "wine explorer"
Icon=wine
Type=Application' > ~/Desktop/Wine32_Explorer.desktop
chmod +x ~/Desktop/Wine32_Explorer.desktop
cp ~/Desktop/Wine32_Explorer.desktop /usr/share/applications/

cd ~/Desktop
echo '[Desktop Entry]
Name=Wine64 Explorer
Exec=bash -c "wine64 explorer"
Icon=wine
Type=Application' > ~/Desktop/Wine64_Explorer.desktop
chmod +x ~/Desktop/Wine64_Explorer.desktop
cp ~/Desktop/Wine64_Explorer.desktop /usr/share/applications/
```

- Winetricks Shotcut
```sh
cd ~/Desktop
echo '[Desktop Entry]
Name=Winetricks32 Explorer
Exec=bash -c "winetricks32 --gui"
Icon=wine
Type=Application' > ~/Desktop/Winetricks32_gui.desktop
chmod +x ~/Desktop/Winetricks32_gui.desktop
cp ~/Desktop/Winetricks32_gui.desktop /usr/share/applications/

cd ~/Desktop
echo '[Desktop Entry]
Name=Winetricks64 Explorer
Exec=bash -c "winetricks64 --gui"
Icon=wine
Type=Application' > ~/Desktop/Winetricks64_gui.desktop
chmod +x ~/Desktop/Winetricks64_gui.desktop
cp ~/Desktop/Winetricks64_gui.desktop /usr/share/applications/
```