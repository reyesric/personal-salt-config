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
      - file: /etc/apache2/conf.d/fqdn.conf

/etc/apache2/sites-available/default:
  file.managed:
    - source: salt://webserver/default.apache


/etc/apache2/sites-enabled/000-default:
  file.symlink:
    - target: /etc/apache2/sites-available/default


/etc/apache2/sites-available/subsonic:
  file.managed:
    - source: salt://webserver/subsonic.apache

/etc/apache2/sites-enabled/subsonic:
  file.symlink:
    - target: /etc/apache2/sites-available/subsonic

/etc/apache2/sites-available/observium:
  file.managed:
    - source: salt://webserver/observium.apache

/etc/apache2/sites-enabled/observium:
  file.symlink:
    - target: /etc/apache2/sites-available/observium

/etc/apache2/conf.d/fqdn.conf:
  file.managed:
    - source: salt://webserver/fqdn.apache
