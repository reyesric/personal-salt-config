/etc/localtime:
   file.symlink:
     - target: /usr/share/zoneinfo/America/Buenos_Aires
     - force: True

openssh-client:
   pkg.installed

openssh-server:
   pkg.installed

ssh:
   service.running:
     - require:
       - pkg: openssh-client
       - pkg: openssh-server
       - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
   file.managed:
     - user: root
     - group: root
     - mode: 644
     - source: salt://ssh/sshd_config
     - require:
       - pkg: openssh-server

zotac-server:
  host.present:
    - ip: 127.0.0.1
    - names: 
      - localhost
      - zotac-server
      - reyesric.homeftp.org

dnsmasq:
  pkg:
    - installed
  service:
    - enable: True
    - running
    - require:
      - pkg: dnsmasq

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://ssh/dnsmasq.conf

