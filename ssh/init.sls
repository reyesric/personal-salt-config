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

/etc/network/interfaces:
   file.managed:
     - user: root
     - group: root
     - mode: 644
     - source: salt://ssh/interfaces
     
/etc/resolv.conf:
   file.managed:
     - user: root
     - group: root
     - mode: 644
     - source: salt://ssh/resolv.conf

/etc/ssh/sshd_config:
   file.managed:
     - user: root
     - group: root
     - mode: 644
     - source: salt://ssh/sshd_config
     - require:
       - pkg: openssh-server

localhost:
  host.present:
    - ip: 127.0.0.1

nixer.info:
 host.present:
    - ip: 127.0.1.1
    - names: 
      - nixer
      - zotac
      - nixer.info

