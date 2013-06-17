base:
  'web-container':
    - webserver
    - postfix

  'torrent*':
    - pip
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
    - pip
    - diamond
 
  'subsonic*':
    - subsonic

  'seafile*':
    - seafile
