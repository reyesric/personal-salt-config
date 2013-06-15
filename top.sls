base:
  'web-container':
    - webserver
    - postfix

  'torrent*':
    - torrent
    - postfix
  
  '*':
    - ssh
    - users
    - apt
    - base

  'zotac-server':
    - lxc-host
    - minidlna
 
  'subsonic*':
    - subsonic
