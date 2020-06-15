#!/bin/sh

# for centos 7

# python
sudo yum -y install libXcomposite libXcursor libXi libXtst libXrandr alsa-lib mesa-libEGL libXdamage mesa-libGL libXScrnSaver

wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh

bash Anaconda3-2020.02-Linux-x86_64.sh -b

# R
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 

# To enable the optional content repo, users with certificate subscriptions run:
sudo subscription-manager repos --enable "rhel-*-optional-rpms"

# Or you can run
sudo yum -y install yum-utils
sudo yum-config-manager --enable "rhel-*-optional-rpms"

export R_VERSION=3.6.3
curl -O https://cdn.rstudio.com/r/centos-7/pkgs/R-${R_VERSION}-1-1.x86_64.rpm
sudo yum -y install R-${R_VERSION}-1-1.x86_64.rpm

/opt/R/${R_VERSION}/bin/R --version

sudo ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
sudo ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

# R packages
sudo yum -y install libxml2-devel curl-devel openssl-devel git nano wget java-1.8.0-openjdk-devel postgresql-devel

sudo /opt/R/${R_VERSION}/bin/R CMD javareconf

# need newer gcc for some R packages
# https://linuxize.com/post/how-to-install-gcc-compiler-on-centos-7/
sudo yum -y install centos-release-scl
sudo yum -y install devtoolset-7
# switch to new gcc in the same shell
source scl_source enable devtoolset-7

# for CXX14, needed for tidymodels
mkdir -p ~/.R
echo "CXX14 = g++ -std=c++1y -Wno-unused-variable -Wno-unused-function -fPIC" >> ~/.R/Makevars
#
Rscript r_pkgs.R
# MM packages

# vim
sudo yum -y install gcc make ncurses ncurses-devel git libcurl-devel openssl-devel libxml2-devel curl
sudo R -e "chooseCRANmirror(graphics=FALSE, ind=14);install.packages(c('languageserver', 'styler', 'formatR'))"

conda install pip
conda install -c conda-forge python-language-server nodejs
pip install radian autopep8
sudo pip3 install jedi
echo  'alias r="radian"' >> ~/.bashrc 

# Install tmux
sudo yum -y install  https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install tmux2u

# Uninstall old versions
sudo yum -y remove vim-enhanced vim-common vim-filesystem

# Download the latest version from Github
cd Downloads
git clone https://github.com/vim/vim.git

# Configure language, especially for python3
# Check config-dir folder of python3 in Anaconda 
# which python
# whereis python

# !!!NEED to revise with-python3-config-dir!!!

cd vim/src
sudo ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp=yes \
            --with-python3-config-dir=/home/parallels/anaconda3/bin/python3.7m-config \
            --prefix=/usr/local/vim8

sudo make && sudo make install

echo "export PATH=$PATH:/usr/local/vim8/bin/" >> ~/.bashrc

# Verify Installed Vim Version, which should be 8.2.xxx
# Also verify it supports python3
vim --version|grep python

# Install vim plug manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim + 'PlugInstall --sync' +qa

# emacs
yum -y install emacs


