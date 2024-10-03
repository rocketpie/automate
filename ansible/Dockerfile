FROM python:3

RUN pip install ansible ansible-pylibssh

ADD /playbooks /playbooks

ENTRYPOINT [ "/bin/bash" ]
