minidlna:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: minidlna
      - file: /etc/minidlna.conf
      - file: /var/cache/minidlna

/var/cache/minidlna:
  file.directory:
    - user: minidlna
    - group: minidlna
    - require:
      - pkg: minidlna

/etc/minidlna.conf:
  file.managed:
    - user: minidlna
    - group: minidlna
    - source: salt://minidlna/minidlna.conf
    - watch:
      - pkg: minidlna
      - file: /var/cache/minidlna
