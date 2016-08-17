#!/usr/bin/env python3

import time

with open("/tmp/checkiecheckcheck", "a") as f:
   f.write("Hello, I am running at " + time.asctime() + "\n")
   f.close()
