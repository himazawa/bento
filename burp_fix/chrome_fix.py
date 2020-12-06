#!/usr/bin/python3
#this forces Burp's chrome binary to run with --no-sandbox
#see https://github.com/higatowa/bento/issues/3

import subprocess
import sys

subprocess.call(["/usr/local/BurpSuiteCommunity/burpbrowser/87.0.4280.66/chrome_old", "--no-sandbox"]+ sys.argv[1:])