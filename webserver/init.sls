libapache2-mod-proxy-html:
  pkg:
    - installed

apache2:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: libapache2-mod-proxy-html
    - watch:
      - pkg: apache2
      - file: /etc/apache2/sites-available/subsonic
      - cmd: a2enmod proxy_http

a2enmod proxy_http:
  cmd:
    - run
    - require:
      - pkg: apache2


/etc/apache2/sites-available/subsonic:
  file.managed:
    - source: salt://webserver/subsonic.apache

/etc/apache2/sites-enabled/subsonic:
  file.symlink:
    - target: /etc/apache2/sites-available/subsonic

