dependencies-pkgs:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php5
      - php5-cli
      - php5-mysql
      - php5-gd
      - php5-snmp
      - php-pear
      - snmp
      - graphviz
      - php5-mcrypt
      - php5-json
      - subversion
      - mysql-server
      - mysql-client
      - rrdtool
      - fping
      - imagemagick
      - whois
      - mtr-tiny
      - nmap
      - ipmitool
      - python-mysqldb      
      - snmp
      - mysql-server

xinetd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - watch:
      - pkg: xinetd
      - file: /etc/xinetd.d/observium_agent

/opt/observium:
  file.directory:
    - user: root

/opt/observium/logs:
  file.directory:
    - user: www-data
    - group: www-data

/etc/cron.d/observium:
  file.managed:
    - source: salt://observium/observium.cron

/root/.my.cnf:
  file.managed:
    - source: salt://observium/my.cnf

/etc/xinetd.d/observium_agent:
  file.managed:
    - source: salt://observium/observium_agent_xinetd

/usr/lib/observium_agent/local:
  file.directory:
    - user: root
    - makedirs: True


hddtemp:
  pkg:
    - installed
  service:
    - enable: True
    - running
    - watch:
      - pkg: hddtemp
      - file: /etc/default/hddtemp

/etc/default/hddtemp:
  file.managed:
    - source: salt://observium/hddtemp.default
    - require:
      - pkg: hddtemp

netcat-traditional:
  pkg:
    - installed


snmpd:
  pkg: 
    - installed
  service:
    - enable: True
    - running
    - watch:
      - pkg: snmpd
      - file: /etc/snmp/snmpd.conf

/etc/snmp/snmpd.conf:
  file.managed:
    - source: salt://observium/snmpd.conf
    - require:
      - pkg: snmpd
