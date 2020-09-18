Role Name
=========

A simple role to install and enable gearman job server (http://gearman.org/). In addition the role installs and enables firewalld with enabling default gearman port tcp/4730.

Requirements
------------

None.

Role Variables
--------------

None.

Dependencies
------------

None.

Example Playbook
----------------


    - hosts: gearman
      roles:
         - { role: opentelekomcloud.common.gearman }

License
-------

Apache

Author Information
------------------

OpenTelekomCloud
