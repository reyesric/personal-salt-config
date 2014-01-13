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
    - source: salt://subsonic/subsonic-4.8.deb

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
   - disabled
   - watch:
     - cmd: subsonic-deb
     - file: /etc/default/subsonic
     - file: /var/music


