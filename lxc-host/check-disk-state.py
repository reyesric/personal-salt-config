#!/usr/bin/env python

import subprocess
import librato

user = '{{ pillar['librato_email'] }}'
token = '{{ pillar['librato_key'] }}'

result = 0
for line in subprocess.check_output ('/usr/sbin/smartctl -i -d ata -n standby /dev/sda'.split()).split('\n'):
  if line.startswith('Power mode'):
    if 'ACTIVE' in line.upper():
      result = 1

api = librato.connect(user, token)
api.submit("power-mode-active-sda", result, type='gauge', description="/dev/sda is ACTIVE or IDLE")
