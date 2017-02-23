#!/bin/bash
echo Building .deb file for the themesaver commandline utility!
mkdir temp
cd temp
wget http://tejasp.me/themesaver/control &>/dev/null
wget http://tejasp.me/themesaver/postinst &>/dev/null
mkdir DEBIAN
mv control DEBIAN/
mv postinst DEBIAN/
chmod +x DEBIAN/postinst
mkdir usr
mkdir usr/bin
cp ../themesaver usr/bin
dpkg-deb -Zgzip -b . ../themeSaver.deb
echo Built deb file. Cleaning up...
cd .. && rm -r temp
echo "Would you like to ssh into your device and install the package? (Y/N)"
read ss2h
if [ "$ss2h" = "Y" ]; then
	read -p "What is the IP of your device?" ip
	read -p "What is the port?" port
	scp -P $port themesaver.deb root@${ip}:/var/mobile/Documents/themeSaver.deb
	ssh root@${ip} 'dpkg -i /var/mobile/Documents/themeSaver.deb'
fi
	
