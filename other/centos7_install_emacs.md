# Install Emacs on CentOS 7
Follow https://snapcraft.io/install/emacs/centos

## Install and enable snapd
``` bash
sudo yum install epel-release
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
```

Then either log out and back in again, or restart your system, to ensure snap’s paths are updated correctly.

## Install GNU Emacs using snap
``` bash
sudo snap install emacs --classic
```

## Install needed Emacs packages
First copy the `.emacs` to the home directory, then run emacs to install the packages.
``` bash
cp .emacs ~/
emacs
```
