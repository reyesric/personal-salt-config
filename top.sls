base:
  'torrent*':
    - pip
    - torrent
  
  '*':
    - ssh
    - users
    - apt
    - base
    - postfix

  'zotac-server':
    - lxc-host
    - minidlna
    - pip
    - diamond
    - subsonic
    - webserver

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
