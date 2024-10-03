#!/bin/sh
ansible all -i ansibletarget, -c ansible.netcommon.network_cli -u automator -k -m vyos.vyos.vyos_facts -e ansible_network_os=vyos.vyos.vyos
