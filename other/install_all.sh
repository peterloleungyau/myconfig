#!/bin/sh

set -x

# for centos 7

# newer version of git
# https://computingforgeeks.com/how-to-install-latest-version-of-git-git-2-x-on-centos-7/
sudo yum -y remove git*
sudo yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
sudo yum -y install git

# git might not have been installed, so allow yum to error out with "Nothing to do"
# from now on, stop at errors
set -e
# python
sudo yum -y install libXcomposite libXcursor libXi libXtst libXrandr alsa-lib mesa-libEGL libXdamage mesa-libGL libXScrnSaver

# conda
# https://linuxize.com/post/how-to-install-anaconda-on-centos-7/
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
bash Anaconda3-2020.02-Linux-x86_64.sh -b
~/anaconda3/bin/conda init
source ~/.bashrc

# R
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 

# To enable the optional content repo, users with certificate subscriptions run:
#sudo subscription-manager repos --enable "rhel-*-optional-rpms"

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
sudo yum -y install libxml2-devel curl-devel openssl-devel nano wget java-1.8.0-openjdk-devel postgresql-devel

sudo /opt/R/${R_VERSION}/bin/R CMD javareconf

# for CXX14, needed for tidymodels and some packages
mkdir -p ~/.R
echo "CXX14 = g++ -std=c++1y -Wno-unused-variable -Wno-unused-function -fPIC" >> ~/.R/Makevars

# for these, use the system old gcc
Rscript r_pkgs.R

# Rstudio
wget https://download1.rstudio.org/desktop/centos7/x86_64/rstudio-1.3.959-x86_64.rpm
sudo yum -y install rstudio-*x86_64.rpm

# need newer gcc for some R packages
# https://linuxize.com/post/how-to-install-gcc-compiler-on-centos-7/
sudo yum -y install centos-release-scl
sudo yum -y install devtoolset-7
# switch to new gcc in the same shell
source scl_source enable devtoolset-7

Rscript -e 'install.packages(c("tidymodels", "xgboost", "SHAPforxgboost"), repos="https://cloud.r-project.org")'
Rscript -e 'devtools::install_github("nredell/shapFlex")'
Rscript -e 'devtools::install_github("tidymodels/parsnip")'
Rscript -e 'devtools::install_github("tidymodels/dials")'
#
# MM packages: TODO

# vim:
sudo yum -y install make ncurses ncurses-devel libcurl-devel openssl-devel libxml2-devel curl
# already installed above
# R -e "chooseCRANmirror(graphics=FALSE, ind=14);install.packages(c('languageserver', 'styler', 'formatR'))"

conda install -y pip
conda install -y -c conda-forge python-language-server nodejs
pip install radian autopep8
sudo pip3 install jedi
echo  'alias r="radian"' >> ~/.bashrc 

# Install tmux
#sudo yum -y install  https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install https://repo.ius.io/ius-release-el7.rpm
sudo yum -y install tmux2u

# Uninstall old versions
sudo yum -y remove vim-enhanced vim-common vim-filesystem

sudo yum -y install ruby ruby-devel

# Download the latest version from Github
#git clone --depth=1 https://github.com/vim/vim.git
git clone https://github.com/vim/vim.git

# Configure language, especially for python3
# Check config-dir folder of python3 in Anaconda 
# which python
# whereis python

# !!!NEED to revise with-python3-config-dir!!!

cd vim/src
# get to a particular commit on May 17, 2020, for consistency
git reset --hard deb17451edd65e2af1d155bce0886e856a716591

LDFLAGS="-fno-lto" ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp=yes \
	    --enable-fail-if-missing \
	    --with-python3-config-dir=$($HOME/anaconda3/bin/python3.7m-config --configdir) \
            --prefix=/usr/local/vim8

make && sudo make install

echo "export PATH=\$PATH:/usr/local/vim8/bin/" >> ~/.bashrc
export PATH=$PATH:/usr/local/vim8/bin/ 

# Verify Installed Vim Version, which should be 8.2.xxx
# Also verify it supports python3
vim --version|grep python

cd ../..

# Install vim plug manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp vimrc_pyr_centos ~/.vimrc
vim -c ':PlugInstall --sync' -c ':qa'

# emacs
# compile emacs ourselves, since the version in yum is old

sudo yum -y install gtk* ncurses* libXpm* giflib* libjpeg* libtiff* libpng*
sudo yum-builddep -y emacs

wget http://mirrors.ustc.edu.cn/gnu/emacs/emacs-26.3.tar.xz
tar xf emacs-26*.xz
cd emacs-26.3
./autogen.sh 
./configure
make
sudo make install
cd ..

cp .emacs ~/.emacs
emacs --batch -l ~/.emacs

