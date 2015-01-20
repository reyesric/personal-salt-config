openjdk-6-jre:
  pkg:
    - installed

subsonic-deb:
  cmd.run:
    - names: 
      - dpkg -i /tmp/subsonic.deb
    - unless: dpkg -s subsonic
    - require: 
      - file: /tmp/subsonic.deb

/tmp/subsonic.deb:
  file.managed:
    - source: salt://subsonic/subsonic-5.0.deb

/etc/default/subsonic:
  file.managed:
    - source: salt://subsonic/subsonic.default
    - user: root
    - group: root

/var/music:
  file.symlink:
    - target: /shared/music
    - force: true

subsonic:
  service:
   - running
   - enable: True
   - watch:
     - cmd: subsonic-deb
     - file: /etc/default/subsonic
     - file: /var/music


