openjdk-6-jre:
  pkg:
    - installed

/etc/default/subsonic:
  file.managed:
    - source: salt://subsonic/subsonic.default
    - user: root
    - group: root

subsonic:
  service:
   - running
   - enable: True
   - watch:
     - file: /etc/default/subsonic


