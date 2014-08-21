base:
  '*':
    - ssh
    - users
    - base
    - postfix
    - minidlna
    - pip
    - subsonic
    - webserver
    - pip
    - torrent
    - fileserver
    - lxc-host
    - observium

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
