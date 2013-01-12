#!/bin/bash
set -x

# uninstall any existing packages
sudo apt-get --yes --purge remove esteidcerts esteidcerts-dev libdigidoc libdigidoc-dev opensc libdigidocpp libdigidocpp-dev qdigidoc qesteidutil

# prepare the home repository folder
mkdir -p $HOME/repository

# use the modified cmake everywhere where needed
for f in esteidcerts libdigidoc libdigidocpp smartcardpp qdigidoc qesteidutil
do
	modpath=idkaart/$f
	test -d $modpath/cmake && (rm -rf $modpath/cmake; ln -s ../cmake $modpath/cmake)
done

set -e

# delete current .deb-s
rm -rf $HOME/repository/*
mkdir -p $HOME/repository/ubuntu/debs

export BUILD_NUMBER=wtf # put your own fun tag here

# remove opensc if built from source or installed from unstable
for f in esteidcerts libdigidoc  libdigidocpp qdigidoc smartcardpp qesteidutil esteidfirefoxplugin estonianidcard opensc
do
	ruby idkaart/current/packaging/build.rb $f
	(cd $HOME/repository && dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz)
done
