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

web-container:
  host.present:
    - ip: 10.0.3.150

torrent-container:
  host.present:
    - ip: 10.0.3.77  

subsonic-container:
  host.present:
    - ip: 10.0.3.76

zotac-server:
  host.present:
    - ip: 10.0.3.1
    - names: 
      - zotac-server
      - reyesric.homeftp.org

seafile-container:
  host.present:
    - ip: 10.0.3.46

