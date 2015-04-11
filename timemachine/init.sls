# based on https://www.64bit.co.uk/ubuntu-as-a-osx-time-machine/

netatalk:
  pkg:
    - installed
  service.running:
    - enable: True
    - sig: cnid_metad
    - watch:
      - pkg: netatalk


avahi-daemon:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - pkg: netatalk
      - file: /etc/avahi/services/deviceinfo.service
      - file: /etc/avahi/services/afpd.service
      - file: /home/timemachine/.com.apple.timemachine.supported

/home/timemachine/.com.apple.timemachine.supported:
  file.managed:
    - source: salt://timemachine/empty.file
    - user: timemachine
    - require:
      - user: timemachine

/etc/avahi/services/afpd.service:
  file.managed:
    - source: salt://timemachine/afpd.service
    - require:
      - pkg: avahi-daemon


/etc/avahi/services/deviceinfo.service:
  file.managed:
    - source: salt://timemachine/deviceinfo.service
    - require:
      - pkg: avahi-daemon

/etc/netatalk/AppleVolumes.default:
  file.managed:
    - source: salt://timemachine/AppleVolumes.default
    - require:
      - pkg: netatalk


/etc/avahi/services/adisk.service:
  file.managed:
    - source: salt://timemachine/adisk.service
    - require:
      - pkg: avahi-daemon




timemachine:
  user.present:
    - home: /home/timemachine
    - shell: /bin/false



