unattended-upgrades:
  pkg:
    - installed

/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://base/50unattended-upgrades
    - require:
      - pkg: unattended-upgrades

/etc/rc.local:
  file.managed:
    - source: salt://base/rc.local
