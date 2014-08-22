minidlna:
  pkg:
    - installed
  service:
    - running
    - requires:
      - pkg: minidlna
    - watch:
      - file: /etc/minidlna.conf
      - file: /var/cache/minidlna


/var/cache/minidlna:
  file.directory:
    - user: minidlna
    - group: minidlna

/etc/minidlna.conf:
  file.managed:
    - user: minidlna
    - group: minidlna
    - source: salt://minidlna/minidlna.conf
    - watch:
      - file: /var/cache/minidlna
