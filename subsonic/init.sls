openjdk-6-jre:
  pkg:
    - installed

subsonic-deb:
  cmd.run:
    - names: 
      - dpkg -i /tmp/subsonic-4.8.deb
    - unless: dpkg -s subsonic
    - require: 
      - file: /tmp/subsonic-4.8.deb

/tmp/subsonic-4.8.deb:
  file.managed:
    - source: salt://subsonic/subsonic-4.8.deb

subsonic:
  service:
   - running
   - require:
     - cmd: subsonic-deb
