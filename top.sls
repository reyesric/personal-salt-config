base:
  'web-container':
    - webserver

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
 
  'subsonic*':
    - subsonic

  'seafile*':
    - seafile

  'rss2imap*':
    - rss2imap
