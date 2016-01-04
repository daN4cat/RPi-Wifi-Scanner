#!/bin/bash
# fichier d'installation de l'application RPi_scanner_wifi


FILEPATH=`dirname $0`

#installer Kismet
sudo apt-get install kismet

#To install RPi.GPIO, you first need to install the Python Development toolkit that RPi.GPIO requires.
echo "======================================"
echo "*** installer python,  RPi.gpio, python-smbus et i2c-tools ***"
sudo apt-get install python-dev
sudo apt-get install python-rpi.gpio
sudo apt-get install i2c-tools
sudo apt-get install python-smbus
#sudo apt-get install ifplugd

#configuration kismet et i2c-tools
#ça depend de l'installation de kismet (installation avec un dep ou avec apt-get)
echo "======================================"
#sudo mv /usr/local/etc/kismet.conf /usr/local/etc/org_kismet.conf
#sudo cp ~/Lcd_project/Kismet.conf /usr/local/etc/kismet.conf

sudo mv /etc/kismet/kismet.conf /etc/kismet/org_kismet.conf
#sudo cp /home/pi/Lcd_project/kismet.conf /etc/kismet/
sudo cp $FILEPATH/kismet.conf /etc/kismet/

sudo echo "i2c-bcm2708" >> /etc/modules
sudo echo -n "i2c-dev" >> /etc/modules
sudo echo -n "dtparam=i2c_arm=on" >> /boot/config.txt

#installer l'application et le fichier de lancement de l'application
#j'ai utilisé sed pour ecrire cette ligne avant la derniere ligne de (exist 0) dans le fichier /etc/rc.local
echo "======================================"
#sudo sed -i '19ish /home/pi/Lcd_project/lance_thread.sh &' /etc/rc.local
ligne=`wc -l /etc/rc.local | cut -f1 -d' '`
sudo sed -i "${ligne}ish $FILEPATH/lance_thread.sh &" /etc/rc.local
echo "sudo python $FILEPATH/main.py" >> $FILEPATH/lance_thread.sh

sudo reboot

