FROM python:3

RUN pip3 install ansible ansible-navigator
RUN curl -fsSL https://get.docker.com | sh

ADD /playbooks /playbooks

ENTRYPOINT [ "/bin/bash" ]