include:
  - pip

flexget:
  pip.installed:
    - require:
      - pkg: python-pip

/home/ricardo/.flexget:
  file.directory:
    - user: ricardo
    - group: ricardo

/home/ricardo/.flexget/config.yml:
  file.managed:
    - user: ricardo
    - group: ricardo
    - source: salt://torrent/flexget.config.yml
    - watch:
      - pip: flexget
      - file: /home/ricardo/.flexget

/etc/cron.d/flexget:
  file.managed:
    - user: root
    - group: root
    - source: salt://torrent/flexget.cron.d
    - require:
      - pip: flexget

mencoder:
  pkg:
    - installed

/usr/local/bin/encodear:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://torrent/encodear.py
    - require:
      - pkg: mencoder

/usr/local/bin/waiton:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://torrent/waiton

/usr/local/bin/online:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://torrent/online.py
