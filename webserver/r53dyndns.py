#!/usr/bin/env python
import os.path
from sh import curl, cli53, mail

TMPFILE=os.path.expanduser('~/.r53dyndns.txt')

last_ip = None
if os.path.exists(TMPFILE):
  last_ip = open(TMPFILE).read()

current_ip = str(curl ('http://canihazip.com/s')).strip()

if current_ip != last_ip:
  output = cli53 ('rrcreate', '-x', 600, 'nixer.info', "", 'A', current_ip, '--replace', '--wait')
  with open(TMPFILE, 'w') as fp:
    fp.write(current_ip)

  mailtext = 'La nueva ip de nixer.info es %(current_ip)s. \n\n%(output)s' % locals()
  mail ('-s', 'nixer.info - notification de cambio de ip', 'ricardo', _in=mailtext)

