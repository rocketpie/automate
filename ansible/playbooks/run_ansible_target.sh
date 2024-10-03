#!/bin/bash

#. ${BASH_SOURCE%/*}/helper.sh
# Explanation:
# BASH_SOURCE stores the name of your process (in most cases it's the full path to your script).
# ${parameter%word} removes suffix pattern word from variable $parameter (in the command above it removes file name /* from the full path stored in variable BASH_SOURCE).

. ${BASH_SOURCE%/*}/enable_ssh_client.sh

ssh-keyscan -H ansibletarget.fritz.box >> ~/.ssh/known_hosts
ansible all -i ansibletarget.fritz.box, -c ansible.netcommon.network_cli -u automator -k -m vyos.vyos.vyos_facts -e ansible_network_os=vyos.vyos.vyos
