base:
  '*':
    - ssh
    - users
    - base
    - postfix

  'zotac-server':
    - minidlna
    - pip
    - diamond
    - subsonic
    - webserver
    - pip
    - torrent
    - fileserver

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
