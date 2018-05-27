{% for user, args in pillar['users'].iteritems() %}
{% for group in args['groups'] %}
{{ group }}:
  group.present:
    - name: {{ group }}
{% endfor %}

{{ user }}:
  user.present:
    - name: {{ salt['pillar.get']('user:name') }}
    - uid: {{ salt['pillar.get']('user:uid') }}
    - gid: {{ salt['pillar.get']('user:gid') }}
    - home: {{ salt['pillar.get']('user:home') }}
{% if 'groups' in args %}
    - groups: {{ args['groups'] }}
{% endif %}

{% if 'nopass_sudo' in args and args['nopass_sudo'] == True %}
/etc/sudoers.d/{{ user }}:
  file.managed:
    - source: salt://tests/files/user.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        user: {{ user }}
{% endif %}

{% if 'key.pub' in args and args['key.pub'] == True %}
{{ user }}_key.pub:
  ssh_auth:
    - present
    - user: {{ user }}
    - source: salt://tests/{{ user }}.pub
{% endif %}
{% endfor %}

{% for absuser, args in pillar['absent_users'].iteritems() %}
{% set all_users = salt['user.list_users']() %}
{% if absuser in all_users %}
{{ absuser }}:
  user.absent:
    - purge: True
    - force: True
{% endif %}
{% endfor %}
