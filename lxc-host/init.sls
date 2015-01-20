iptables-persistent:
  pkg:
    - installed

lm-sensors:
  pkg: 
    - installed

molly-guard:
  pkg:
    - installed

usbmount:
  pkg:
    - installed

/etc/usbmount/usbmount.conf:
  file.managed:
    - source: salt://lxc-host/usbmount.conf
    - require:
      - pkg: usbmount


/etc/sensors.d/zbox-hd-id-11:
  file.managed:
    - source: salt://lxc-host/sensors.d.conf
    - mode: 644

smartmontools:
  pkg:
    - installed


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
    - source: salt://lxc-host/fstab.base
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




curl:
  pkg:
    - installed

/usr/local/bin/duckdns.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://lxc-host/duckdns.sh
    - require:
      - pkg: curl

/home/ricardo/duckdns:
  file.directory:
    - user: ricardo
    - group: ricardo



/etc/cron.d/duckdns:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/duckdns.cron.d
    - require:
      - file: /usr/local/bin/duckdns.sh
      - file: /home/ricardo/duckdns




