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
    - collectd

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
