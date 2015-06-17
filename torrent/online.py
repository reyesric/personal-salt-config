#!/usr/bin/env python

from sh import ping

try:
	retcode = ping('-q', '-c', 1, 'google.com')
except:
	exit (1)

exit(0)