{% for user, args in pillar['users'].iteritems() %}
{% for group in args['groups'] %}
{{ group }}:
  group.present:
    - name: {{ group }}
{% endfor %}

{{ user }}:
  group.present:
    - gid: {{ args['gid'] }}
  user.present:
    - name: {{ args['name'] }}
    - fullname: {{ args['fullname'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
{% if 'groups' in args %}
    - groups: {{ args['groups'] }}
{% endif %}

{% if 'nopass_sudo' in args and args['nopass_sudo'] == True %}
/etc/sudoers.d/{{ user }}:
  file.managed:
    - source: salt://users/files/user.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        user: {{ user }}
{% endif %}

{% if 'key.pub' in args and args['key.pub'] == True %}
{{ user }}_key.pub:
  ssh_auth.present:
    - user: {{ user }}
    - source: {{ args['ssh_keypath'] }}
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
