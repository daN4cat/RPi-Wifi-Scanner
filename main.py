#!/usr/bin/python

from time import sleep
from os import path
import glob
import re
from Adafruit_CharLCDPlate import Adafruit_CharLCDPlate

if __name__ == '__main__':

    lcd = Adafruit_CharLCDPlate()
    lcd.begin(16, 2)
    lcd.clear()
    lcd.message("  O3STECH \nRPi Scanner WIFI")
    sleep (3)
    lcd.clear()
    lcd.message ("MAC dev Number \n")
    lcd.setCursor(9,1)
    lcd.message ("devices")
    newest_file = path.realpath(max(glob.iglob('*.nettxt') ,key= path.getctime))
    while True :
        sleep(5)
        with open(newest_file ,"r") as f:
            result = re.findall("MAC (..:..:..:..:..:..)",f.read())
            unique = list(set(result))
            nbre_mac = len(unique)
        lcd.setCursor(0,1)
        lcd.message(str(nbre_mac))

