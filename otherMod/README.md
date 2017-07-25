Adafruit-Retrogame
==================

Raspberry Pi GPIO-to-virtual-keyboard utility for classic game emulators.

How-to: https://learn.adafruit.com/retro-gaming-with-raspberry-pi

### NEED HELP?

__Visit forums.adafruit.com (General Project Help) for retrogame-related questions.__ GitHub's "Issues" tab is for bug reports and feature requests. __99% of retrogame problems are configuration, not bugs.__ Make sure to follow the "RetroPie 2.0+ Compatibility" directions below. Also, use Broadcom GPIO numbers, _not_ the physical pin index.

When requesting help, please be thorough in your description. Which model of Raspberry Pi, what release of RetroPie (or other OS image), and (if the trouble is localized) which system emulator exactly? For hardware-related issues, photos are extremely helpful. Thanks!

For emulation-related questions (e.g. individual games not working), please use a support forum relevant to the software in use, e.g. the RetroPie Forum at https://retropie.org.uk/forum/ if using that package. Adafruit does not develop these emulators or the EmulationStation front-end.

### NEW: Configuration file

retrogame now loads its pin/key settings from a file; no code editing required. An example file 'retrogame.cfg' is included in the 'configs' directory, copy this file to the /boot directory so retrogame can find it (/boot makes it easier to edit with the card in a reader on another system). Alternately, an absolute pathname to a settings file can be passed on the command line. This file can be edited live, no need to restart retrogame after making changes.

__THE ioStandard[] AND ioTFT[] TABLES NO LONGER EXIST IN THE SOURCE CODE. You should not need to edit any code to make retrogame work.__ Everything is handled through the configuration file now. Some guides may be out of date and still refer to the old way; these will be updated over time.

### RetroPie 2.0+ Compatibility

Note that by default retrogame won't work with SDL2 applications that depend on evdev for input events. Specifically this means applications like the latest version of RetroPie and EmulationStation won't be able to see key events generated by retrogame. However you can fix this issue by adding a small custom udev rule to make retrogame keyboard events visible to SDL2.

Connect to your Raspberry Pi in a terminal/SSH session and execute the following command to create and edit the file /etc/udev/rules.d/10-retrogame.rules:

````
sudo nano /etc/udev/rules.d/10-retrogame.rules
````

Once the nano text editor loads, copy this single line into the file:

````
SUBSYSTEM=="input", ATTRS{name}=="retrogame", ENV{ID_INPUT_KEYBOARD}="1"
````

Save the file by pressing Ctrl-O and enter, then press Ctrl-x to exit. Restart your Raspberry Pi and run retrogame again, now button presses should register in SDL2 applications like the EmulationStation frontend to RetroPie