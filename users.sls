{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  user.present:
    - name: {{ salt['pillar.get']('user:name') }}
    - uid: {{ salt['pillar.get']('user:uid') }}
    - gid: {{ salt['pillar.get']('user:gid') }}
    - home: {{ salt['pillar.get']('user:home') }}


{% if 'key.pub' in args and args['key.pub'] == True %}
{{ user }}_key.pub:
  ssh_auth:
    - present
    - user: {{ user }}
    - source: salt://users/{{ user }}/keys/key.pub
{% endif %}
{% endfor %}
