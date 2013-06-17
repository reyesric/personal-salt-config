include:
  - pip

transmission-daemon:
  pkg:
    - installed
  service:
    - running
    - enable: true
    - reload: true
    - watch:
      - pkg: transmission-daemon
      - file: /etc/transmission-daemon/settings.json

python-transmissionrpc:
  pkg:
    - installed
    - require:
      - pkg: transmission-daemon

/etc/transmission-daemon/settings.json:
  file.managed:
    - source: salt://torrent/settings.json
    - user: debian-transmission
    - group: debian-transmission

/srv/torrents:
  file.directory:
    - user: debian-transmission

/srv/torrents/incomplete:
  file.directory:
    - user: debian-transmission
    - require:
      - file: /srv/torrents

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

/usr/local/bin/encodear.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://torrent/encodear.sh
    - require:
      - pkg: mencoder
