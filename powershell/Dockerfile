FROM python:3

RUN apt-get update \
    && wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/powershell_7.4.5-1.deb_amd64.deb \
    && dpkg -i powershell_7.4.5-1.deb_amd64.deb \
    && apt-get install -f \
    && rm powershell_7.4.5-1.deb_amd64.deb

#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT [ "/usr/bin/pwsh" ]
