collectd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/collectd/collectd.conf

/etc/collectd/collectd.conf:
  file.managed:
    - source: salt://collectd/collectd.conf
    - template: jinja

