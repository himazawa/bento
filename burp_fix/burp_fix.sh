#!/bin/bash
 cd /usr/local/BurpSuiteCommunity/burpbrowser/*/
 mv chrome chrome_old
 cp /home/tamago/burp_fix/chrome_fix.py chrome
 chmod +x chrome