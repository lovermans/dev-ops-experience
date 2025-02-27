

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
Add myusername as sudoers from nano text editor.

```
# User privilege specification
root    ALL=(ALL:ALL) ALL
myusername ALL=(ALL:ALL) ALL
```

Ctrl + X then Y then Enter

```sh
exit
```

```sh
pd sh ubuntu --user myusername --shared-tmp --fix-low-ports
sudo apt install xfce4 xfce4-goodies tigervnc-standalone-server -y
sudo apt install openssh-server -y
vncserver -autokill -xstartup startxfce4 -localhost no -nolisten tcp :1
sudo apt install xrdp
sudo service xrdp restart
```

```
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
```

```
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```

```
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx
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