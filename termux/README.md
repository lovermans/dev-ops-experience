
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

Then disable all default and/or vendor battery optimization settings for termux app.

# Disable Phantom Process Killer on Android 12 or 13
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

## Basic Setup Ubuntu
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
Save file : <kbd>Ctrl</kbd>+<kbd>X</kbd> and press <kbd>Y</kbd> then <kbd>Enter</kbd> to exit nano text editor.

- Exit Ubuntu
```sh
exit
```

- Login Ubuntu As New Created User
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername
``` 

## Install Ubuntu Desktop Environment (for remote VNC or Windows Remote Desktop)
- Install XFCE Desktop Environtment (suitable for low resources devices)
```sh
sudo apt install xfce4 xfce4-goodies tigervnc-standalone-server firefox dbus-x11
```

- Start VNC Server
```sh
vncserver -xstartup startxfce4 -autokill -localhost no -nolisten tcp :1
```

- Stop VNC Server
```sh
vncserver -kill :1
```

# Fix Audio Proot Distro Ubuntu
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
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername 'export PULSE_SERVER=127.0.0.1'
```

- Connect Pulse Audio
```sh
export PULSE_SERVER=127.0.0.1
```

- Start VNC Server
```sh
vncserver -xstartup startxfce4 -autokill -localhost no -nolisten tcp :1
```

# Desktop Environmet Hardware Acceleration (Mali GPU)
- Exit Proot Distro, Back to Termux and Install Following Package
```sh
pkg install tur-repo; pkg install x11-repo; pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android virglrenderer-android
```

- Start Pulseaudio in Termux
```sh
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
```

- Login to Proot Distro Ubuntu
```sh
proot-distro login ubuntu --fix-low-ports --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --user yournewusername 'export PULSE_SERVER=127.0.0.1'
```

- Connect Pulse Audio
```sh
export PULSE_SERVER=127.0.0.1
```

- Start VNC Server
```sh
vncserver -xstartup startxfce4 -autokill -localhost no -nolisten tcp :1
```

# Setup PHP in Proot Distro Ubuntu
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

# Setup Nginx in Proot Distro Ubuntu
```sh
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx
apt update
```

# Setup VSCode in Proot Distro Ubuntu
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
