lxc:
  pkg:
    - installed

iptables-persistent:
  pkg:
    - installed

lm-sensors:
  pkg: 
    - installed

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

/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/resolv.conf
    - require:
      - pkg: lxc


rsnapshot:
  pkg:
    - installed

/media/2tb/rsnapshots:
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
      - file: /media/2tb/rsnapshots



include:
  - users
  - pip

flask:
  pip.installed:
    - require:
      - pkg: python-pip

