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

  'zotac-server':
    - lxc-host
    - minidlna
 
  'subsonic*':
    - subsonic
