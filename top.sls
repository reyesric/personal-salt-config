base:
  'web-container':
    - webserver

  'torrent-container':
    - torrent
  
  '*':
    - ssh
    - users

  'zotac-server':
    - lxc-host
    - minidlna
