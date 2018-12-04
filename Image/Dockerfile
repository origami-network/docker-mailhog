FROM microsoft/windowsservercore:ltsc2016

ARG ARG_MAILHOG_VERSION
ARG ARG_MAILHOG_URL="https://github.com/mailhog/MailHog/releases/download/v${ARG_MAILHOG_VERSION}/MailHog_windows_amd64.exe"
ARG ARG_MAILHOG_PATH=C:\\Mailhog

RUN powershell.exe -Command $ErrorActionPreference = 'Stop' ; \
  $unused = New-Item -ItemType Directory $env:ARG_MAILHOG_PATH ; \
  $filePath = Join-Path $env:ARG_MAILHOG_PATH "mailhog.exe" ; \
  [Net.ServicePointManager]::SecurityProtocol = 'Tls', 'Tls11', 'Tls12' ; \
  Invoke-WebRequest $env:ARG_MAILHOG_URL -OutFile $filePath

ENV MH_SMTP_BIND_ADDR=0.0.0.0:25
EXPOSE 25/tcp

WORKDIR ${ARG_MAILHOG_PATH}
SHELL ["cmd", "/S", "/C"]
ENTRYPOINT [ "mailhog.exe" ]
