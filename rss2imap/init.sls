/srv/rss2imap:
  file.directory:
    - user: ricardo

include:
  - users

https://github.com/rcarmo/rss2imap.git:
  git.latest:
    - rev: master
    - target: /srv/rss2imap
    - require:
      - pkg: git-core
      - file: /srv/rss2imap

/etc/cron.d/rss2imap:
  file.managed:
    - user: root
    - group: root
    - source: salt://rss2imap/cron.file
    - require:
      - git: https://github.com/rcarmo/rss2imap.git
