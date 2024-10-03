FROM python:3

RUN pip install ansible ansible-pylibssh
RUN apt-get update \
    && apt-get install sshpass

ADD /playbooks /playbooks
ADD /inventory /etc/ansible/inventory

ENTRYPOINT [ "/bin/bash" ]
