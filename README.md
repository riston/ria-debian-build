Building RIA ID-card software v3.7.1 packages on Debian
=======================================================

*  This is provided on AS IS basis, no warranty whatsoever.
*  This works for me on Debian 7.0 amd64, YMMV. Ubuntu 12.10 also.
*  Debian 6.0 (Squeeze) users a stuck with v3.6 and should use the [debian6 branch](https://github.com/martinpaljak/ria-debian-build/tree/debian6)
*  Make sure you can use sudo (add yourself to "sudo" group)!
*  There are proper tarballs now available, for packages built from those tarballs, have a look at https://code.launchpad.net/~boamaod/+junk/eid-debs

```
# clone this repostiory (to get the diff!)
git clone https://github.com/martinpaljak/ria-debian-build.git
cd ria-debian-build
# install dependencies
sudo apt-get install --no-install-recommends subversion doxygen xsdcxx cdbs \
cmake build-essential libxml2-dev ruby zip rubygems dpkg-dev libssl-dev \
libp11-dev libpcsclite-dev libldap2-dev libgtk2.0-dev libqt4-dev \
libxerces-c-dev libxml-security-c-dev libtool autoconf automake fakeroot

# check out the source code.
svn co https://svn.eesti.ee/projektid/idkaart_public/branches/3.7.1 idkaart

# add your private repository to /etc/apt/sources.list. DO THIS ONLY ONCE!
sudo sh -c "echo 'deb file://$HOME/repository ./' >> /etc/apt/sources.list"

# patch! :-)
mkdir -p idkaart/current && ln -s  ../packaging idkaart/current/packaging
(cd idkaart && patch -p0 < ../debian.diff)

# build all the crap
./builder.sh

# install the packages
sudo apt-get update
sudo apt-get install qdigidoc qesteidutil esteidcerts esteidfirefoxplugin opensc

# configure Chrome for ID-card
sudo apt-get install libnss3-tools
modutil  -dbdir sql:$HOME/.pki/nssdb -delete opensc-pkcs11
modutil  -dbdir sql:$HOME/.pki/nssdb -add opensc-pkcs11 -libfile onepin-opensc-pkcs11.so -mechanisms FRIENDLY

# then go to "about:plugins" and select "Always allow" for "EstEID plug-in" 
# (or you will have to manually select "Always allow for this site")

```

*  E-mail martin@martinpaljak.net if you find something fishy in this small
tutorial.
*  E-mail package contacts if you find problems with packages or software.

Good luck.
