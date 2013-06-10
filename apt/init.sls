/etc/apt/apt.conf.d/01proxy:
  file.managed:
    - source: salt://apt/01proxy
    - user: root
    - group: root
    
