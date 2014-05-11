zsh:
  pkg:
    - installed

nano:
  pkg:
    - installed

dnsutils:
  pkg:
    - installed

ricardo:
  user.present:
    - home: /home/ricardo
    - shell: /bin/zsh
    - require:
      - pkg: zsh
  ssh_auth:
    - present
    - source: salt://users/authorized_keys
    - user: ricardo

git-core:
  pkg:
    - installed

/home/ricardo/.zshrc:
  file.managed:
    - user: ricardo
    - group: ricardo
    - source: salt://users/zshrc
    - require:
      - user: ricardo

/etc/sudoers.d/ricardo:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - source: salt://users/sudoer
    
