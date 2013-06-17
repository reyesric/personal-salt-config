include:
  - pip

include:
  - users

make:
  pkg:
    - installed

pbuilder:
  pkg:
    - installed

python-mock:
  pkg:
    - installed

python-configobj:
  pkg:
    - installed

python-support:
  pkg:
    - installed

cdbs:
  pkg:
    - installed

https://github.com/BrightcoveOS/Diamond.git:
  git.latest:
    - rev: master
    - target: /home/ricardo/.diamond
    - require:
      - pkg: git-core

diamond-build:
  cmd.run:
    - names:
      - cd /home/ricardo/.diamond && make builddeb
    - unless: ls /home/ricardo/.diamond/build
    - require:
      - git: https://github.com/BrightcoveOS/Diamond.git
      - pkg: make
      - pkg: pbuilder
      - pkg: python-mock
      - pkg: python-configobj
      - pkg: python-support
      - pkg: cdbs

diamond-install:
  cmd.run:
    - names:
      - dpkg -i /home/ricardo/.diamond/build/diamond*.deb
    - unless: dpkg -s diamond
    - require:
      - cmd: diamond-build

diamond:
  service:
    - running
    - watch: 
      - cmd: diamond-install
      - file: /etc/diamond/diamond.conf
      - pip: librato-metrics

/etc/diamond/diamond.conf:
  file.managed: 
    - source: salt://diamond/diamond.conf
    - template: jinja

{% for collector in 'CPUCollector', 'DiskSpaceCollector', 'LoadAverageCollector', 'MountStatsCollector', 'SmartCollector', 'DiskUsageCollector', 'MemoryCollector', 'NetworkCollector' %}
/etc/diamond/collectors/{{ collector }}.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://diamond/{{ collector }}.conf
{% endfor %}

librato-metrics:
  pip.installed:
    - require:
      - pkg: python-pip


/etc/sudoers.d/diamond:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - source: salt://diamond/diamond.sudoer


