
## Disable Phantom Process Killer on Android 12 and Above

### Instal Android Tools

```sh
pkg update
pkg upgrade
pkg install android-tools
```

### Turn On Developer Option and Wifi Debugging

```sh
adb pair ip:port paring_code
adb connect ip:adbport
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
adb shell settings put global settings_enable_monitor_phantom_procs false
adb reboot
```

## Setup Proot Distro Ubuntu

### Update Termux Package then Instal Ubuntu
```sh
termux-setup-storage
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install wget
pkg install git
pkg install nmap
pkg install proot-distro
proot-distro install ubuntu
```

### Login to Installed Ubuntu and add password for root user
```sh
pd sh ubuntu --shared-tmp --fix-low-ports
passwd
```
Fill and confirm new password then Enter.


### Update Ubuntu Package and Add New User
```sh
apt update
apt upgrade
apt install sudo nano adduser -y

adduser newusername
nano /etc/sudoers
```
Add newusername as sudoers from nano text editor.

```
# User privilege specification
root    ALL=(ALL:ALL) ALL
newusername ALL=(ALL:ALL) ALL
```
Save and exit : Ctrl + X then press Y and Enter. Then logout from root user.

```sh
exit
```

### Login to Ubuntu with new user and add password
```sh
pd sh ubuntu --user newusername --shared-tmp --fix-low-ports
passwd
```

### Install Ubuntu Desktop Environment (for remote VNC or Windows Remote Desktop)
```sh
sudo apt install xfce4 xfce4-goodies tigervnc-standalone-server -y
sudo apt install openssh-server -y
vncserver -autokill -xstartup startxfce4 -localhost no -nolisten tcp :1
sudo apt install xrdp
sudo service xrdp restart
```

## Setup PHP in Proot Distro Ubuntu
```sh
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
apt update
sudo apt install php8.4-cli php8.4-fpm
sudo apt install php8.4-bcmath
sudo apt install php8.4-curl
sudo apt install php8.4-xml
sudo apt install php8.4-gd
sudo apt install php8.4-gmp
sudo apt install php8.4-intl
sudo apt install php8.4-openssl
sudo apt install php8.4-mbstring
sudo apt install php8.4-mysqli
sudo apt install php8.4-sqlite3
sudo apt install php8.4-protobuf
sudo apt install php8.4-soap
sudo apt install php8.4-zip
```

## Setup Nginx in Proot Distro Ubuntu
```sh
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx
apt update
```

## Setup VSCode in Proot Distro Ubuntu
```sh
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
```

```sh
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```
