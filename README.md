# salt-formula-users

### What is this repository for? ###

* Repository for creating users on different os Ubuntu and Centos
* Version 0.1


### How do I get set up? ###

* Clone repository to salt master
* Add path of the repo folder to /etc/salt/master (option file_roots:)
* Add path of the pillar folder to /etc/salt/master (option pillar_roots:)

### How to use it? ###

* You should run the salt command with the next parametres

Example of using formula:

salt '*' state.sls tests

* In case if you want to configure users, use the next files

For centos users: tests/pillar/users/centos.sls
For ubuntu users: tests/pillar/users/ubuntu.sls

