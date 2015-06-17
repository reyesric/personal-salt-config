base:
  '*':
    - lxc-host
    - ssh
    - users
    - base
    - postfix
    - pip
    - subsonic
    - webserver
    - pip
    - torrent
    - fileserver
    - observium

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
