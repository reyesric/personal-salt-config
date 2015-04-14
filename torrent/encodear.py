#!/usr/bin/env python

from sh import nice
import argparse
import os.path, os
from sh import tempfile
from sh import mail

parser = argparse.ArgumentParser (description='Genera un AVI con subtitulos incluidos')
parser.add_argument('video', help='Video original')
parser.add_argument('subtitulos', help='Archivo de subtitulos (.srt)')
parser.add_argument('output', help='Nombre del archivo de salida')
parser.add_argument('-f', '--force', action='store_true', help='Sobreescribir el archivo de salida si existe')
parser.add_argument('-e', '--encoding', default='latin1', help='Encoding del archivo de subtitulos (latin1 por default)')
args = parser.parse_args()


if os.path.splitext(args.subtitulos)[-1].lower() != '.srt':
  raise ValueError ('El archivo de subtitulos no parece un archivo valido')

for fname in (args.video, args.subtitulos):
  if not os.path.exists(fname):
    raise ValueError ('El archivo %s no existe' % fname)

if os.path.exists(args.output):
  if not args.force:
    raise ValueError ('El archivo de salida %s ya existe (use -f para sobreescribirlo)' % args.output)

assert(os.path.splitext(args.output)[-1].lower() == '.avi')

tmp = tempfile().strip()
try:
  for line in nice.mencoder(args.video, '-oac', 'mp3lame', '-ovc', 'xvid', '-vf', 'scale', '-zoom', '-xy', 720, '-xvidencopts', 'bitrate=1500:me_quality=6:threads=2:pass=1', '-sub', args.subtitulos, '-subfont-text-scale', 2.8, '-subcp', args.encoding, '-subpos', 85, '-passlogfile', tmp, '-o', '/dev/null', '-quiet', _iter=True):
    print line.strip()

  for line in nice.mencoder(args.video, '-oac', 'mp3lame', '-ovc', 'xvid', '-vf', 'scale', '-zoom', '-xy', 720, '-xvidencopts', 'bitrate=1500:me_quality=6:threads=2:pass=2', '-sub', args.subtitulos, '-subfont-text-scale', 2.8, '-subcp', args.encoding, '-subpos', 85, '-passlogfile', tmp, '-o', args.output, '-quiet', _iter=True):
    print line.strip()

  mail ('-s', "encode de %s terminado" % args.output, 'chiquito@gmail.com', _in='Proceso terminado')
finally:
  os.remove (tmp)




