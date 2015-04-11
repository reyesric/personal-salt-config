base:
  '*':
    - lxc-host
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
    - observium

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
