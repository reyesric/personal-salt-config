lxc:
  pkg:
    - installed

iptables-persistent:
  pkg:
    - installed

lm-sensors:
  pkg: 
    - installed

/etc/sensors.d/zbox-hd-id-11:
  file.managed:
    - source: salt://lxc-host/sensors.d.conf
    - mode: 644

ddclient:
  pkg:
    - installed

smartmontools:
  pkg:
    - installed


/etc/ddclient.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/ddclient.conf
    - mode: 600
    - require:
      - pkg: ddclient


byobu:
  pkg:
    - installed

/media/2tb:
  file.directory:
    - user: root
    - group: root
    
/media/samsung1tera:
  file.directory:
    - user: root
    - group: root

/etc/fstab:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/fstab
    - require:
      - file: /media/2tb
      - file: /media/samsung1tera

rsnapshot:
  pkg:
    - installed

/media/samsung1tera/rsnaphosts:
  file.directory:
    - user: root
    - group: root


/etc/rsnapshot.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/rsnapshot.conf
    - require:
      - pkg: rsnapshot

/etc/cron.d/rsnapshot:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/rsnapshot.cron.d
    - require:
      - pkg: rsnapshot
      - file: /media/samsung1tera/rsnaphosts



include:
  - users
  - pip

flask:
  pip.installed:
    - require:
      - pkg: python-pip

