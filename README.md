Building RIA ID-card software v3.7.0 packages on Debian
=======================================================

This is provided on AS IS basis, no warranty whatsoever.

This works for me on Debian 6.0/7.0 amd64, YMMV.

```
# install dependencies
sudo apt-get install --no-install-recommends subversion doxygen xsdcxx cdbs cmake build-essential libxml2-dev ruby zip rubygems dpkg-dev libssl-dev libp11-dev libpcsclite-dev libldap2-dev libgtk2.0-dev libqt4-dev libxerces-c-dev libxml-security-c-dev libtool autoconf automake

# Check out the source code.
svn co https://svn.eesti.ee/projektid/idkaart_public/trunk idkaart

# add your private repository to /etc/apt/sources.list
sudo sh -c "echo 'deb file://$HOME/repository ./' >> /etc/apt/sources.list"

# patch! :-)
mkdir -p idkaart/current && ln -s  ../packaging idkaart/current/packaging
(cd idkaart && patch -p0 < ../debian.diff)

# build all the crap
./builder.sh

# install the metapackage
sudo apt-get update
sudo apt-get install estonianidcard

# install OpenSC from unstable (or modify builder.sh script)
sudo apt-get install opensc/unstable

# configure Chrome (Firefox 8 is also "almost usable")
sudo apt-get install libnss3-tools
modutil  -dbdir sql:$HOME/.pki/nssdb -delete opensc-pkcs11
modutil  -dbdir sql:$HOME/.pki/nssdb -add opensc-pkcs11 -libfile /usr/lib/onepin-opensc-pkcs11.so -mechanisms FRIENDLY
```

*  E-mail martin@martinpaljak.net if you find something fishy in this small
tutorial.
*  E-mail package contacts if you find problems with packages or software.

Good luck.