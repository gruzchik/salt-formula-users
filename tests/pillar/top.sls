{% set this = salt['grains.filter_by']({
    'Debian': {'newuser': 'ubuntu'},
    'RedHat': {'newuser': 'centos'},
}, default='Debian') %}

base:
  '*':
    - users/{{ this.newuser }}
