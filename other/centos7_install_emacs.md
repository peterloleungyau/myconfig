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

## Prevent snapd from auto-updating
Following https://askubuntu.com/questions/1045542/how-to-stop-snapd-from-auto-updating
After the installation above, since we would not be updating the emacs often, we can turn off snapd to prevent auto-updating, to prevent unexpected breaking.
``` bash
sudo systemctl stop snapd.service
# to prevent snapd from starting when the machine restarts
systemctl mask snapd.service
sudo kill -9 $(pgrep snapd)
```
