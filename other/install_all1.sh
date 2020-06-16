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
# switch to new gcc and continue the remaining parts using the new gcc
scl enable devtoolset-7 ./install_all2.sh

