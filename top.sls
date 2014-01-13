base:
  '*':
    - ssh
    - users
    - base
    - postfix

  'zotac-server':
    - minidlna
    - pip
    - subsonic
    - webserver
    - pip
    - torrent
    - fileserver
    - lxc-host

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
