#!/bin/sh

set -x
set -e

# continue after scl_source

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

# to remove anaconda paths from $PATH, to prevent error in compiling emacs
# suggested by https://stackoverflow.com/a/2108540
# first make it to have colon on both sides
WORK=:$PATH:
REMOVE1=$HOME/anaconda3/bin
REMOVE2=$HOME/anaconda3/condabin
# remove the path with guard colon, replace with a single colon
WORK=${WORK/:$REMOVE1:/:}
WORK=${WORK/:$REMOVE2:/:}
# remove the extra colon and front and end
WORK=${WORK%:}
WORK=${WORK#:}
PATH=$WORK

#
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

