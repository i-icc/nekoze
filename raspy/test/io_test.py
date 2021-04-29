import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BCM)

redLED = 13

GPIO.setup(redLED, GPIO.OUT)

for _ in range(5):
    GPIO.output(redLED, True)
    time.sleep(1)
    GPIO.output(redLED, False)
    time.sleep(1)
