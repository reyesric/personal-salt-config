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



{% for container in pillar['containers'] %}

create_container_{{container}}:
  cmd.run:
    - name: lxc-create -n {{container}}-container -t ubuntu
    - unless: stat /var/lib/lxc/{{container}}-container/rootfs

/var/lib/lxc/{{container}}-container/rootfs/srv:
  file.directory:
    - user: root
    - group: root
    - require:
      - cmd: create_container_{{container}}

/var/lib/lxc/{{container}}-container/rootfs/srv/pillar:
  file.directory:
    - user: root
    - group: root
    - require:
      - cmd: create_container_{{container}}

/var/lib/lxc/{{container}}-container/rootfs/srv/salt:
  file.directory:
    - user: root
    - group: root
    - require:
      - cmd: create_container_{{container}}

/var/lib/lxc/{{container}}-container/fstab:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/{{container}}-container.fstab
    - container: {{container}}
    - template: jinja
    - require:
      - cmd: create_container_{{container}}

/var/lib/lxc/{{container}}-container/config:
  file.managed:
    - user: root
    - group: root
    - container: {{container}}
    - ipaddr: {{ pillar['containers'][container]['ip'] }}
    - macaddr: {{ pillar['containers'][container]['mac'] }}
    - source: salt://lxc-host/lxc-config.jinja
    - template: jinja
    - require:
      - file: /var/lib/lxc/{{container}}-container/fstab

/etc/lxc/auto/{{container}}.conf:
  file.symlink:
    - target: /var/lib/lxc/{{container}}-container/config
    - require: 
      - file: /var/lib/lxc/{{container}}-container/config

{% endfor %}

include:
  - users
  - pip

flask:
  pip.installed:
    - require:
      - pkg: python-pip

https://github.com/lxc-webpanel/LXC-Web-Panel.git:
  git.latest:
    - rev: master
    - target: /srv/lwp
    - require:
      - pkg: git-core
      - pip: flask

/etc/init.d/lwp:
  file.managed:
    - user: root
    - group: root
    - source: salt://lxc-host/lwp.init.d
    - mode: 700
    - require:
      - git: https://github.com/lxc-webpanel/LXC-Web-Panel.git

lwp:
  service:
    - running
    - enable: True
    - sig: lwp
    - require:
      - file: /etc/init.d/lwp
