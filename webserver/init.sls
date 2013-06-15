nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: nginx
      - file: /etc/nginx/sites-available/default



/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://webserver/default

