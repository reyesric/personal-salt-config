samba:
  pkg:
    - installed

smbd:
  service:
    - running
    - watch:
      - pkg: samba
      - file: /etc/samba/smb.conf



/etc/samba/smb.conf:
  file.managed:
    - source: salt://fileserver/smb.conf

