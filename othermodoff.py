#!/bin/python  
  
import RPi.GPIO as GPIO  
import time  
import os  

GPIO_PIN=4

GPIO.setmode(GPIO.BCM)  
GPIO.setup(GPIO_PIN, GPIO.IN, pull_up_down = GPIO.PUD_UP)  
 
def Shutdown(channel):  
    os.system("sudo shutdown -h now")  

GPIO.add_event_detect(GPIO_PIN, GPIO.FALLING, callback = Shutdown)  
 
while 1:  
    time.sleep(.25)