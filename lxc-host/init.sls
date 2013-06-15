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

/etc/ddclient.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/ddclient.conf
    - mode: 600


byobu:
  pkg:
    - installed

apt-cacher:
  pkg:
    - installed

/etc/iptables.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/iptables.rules
    - mode: 600


iptables-reload:
  cmd.run:
    - names:
      - /etc/init.d/iptables-persistent reload
    - watch:
      - file: /etc/iptables.rules



/media/wd500:
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
