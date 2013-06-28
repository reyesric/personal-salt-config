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

apt-cacher:
  pkg:
    - installed

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
    - require:
      - file: /media/wd500
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



{% for container, ipaddr in pillar.get('containers_ipaddrs', {}).items() %}

/var/lib/lxc/{{container}}-container/fstab:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/{{container}}-container.fstab

/var/lib/lxc/{{container}}-container/config:
  file.managed:
    - user: root
    - group: root
    - container: {{container}}
    - ipaddr: {{ipaddr}}
    - macaddr: {{ pillar['containers_macaddrs'][container] }}
    - source: salt://lxc-host/lxc-config.jinja
    - template: jinja

{% endfor %}
