

```sh
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
pkg install wget
pkg install git
termux-setup-storage
proot-distro install ubuntu
pd sh ubuntu
```

```sh
apt update
apt upgrade
apt install sudo nano adduser -y

adduser myusername
nano /etc/sudoers
```
Change 
# User privilege specification
root    ALL=(ALL:ALL) ALL
myusername ALL=(ALL:ALL) ALL

Ctrl + X then Y then Enter

```sh
exit
```

```sh
pd sh ubuntu --user myusername
sudo apt install dbus-x11 ubuntu-desktop -y
```