FROM microsoft/iis

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG VERSION=latest

# Download the NewRelic Infrastructure Monitor
ADD https://download.newrelic.com/infrastructure_agent/windows/newrelic-infra.msi /newrelic-infra.msi 
RUN Start-Process "msiexec.exe" -ArgumentList "/i","C:\\newrelic-infra.msi","/qn","/norestart" -Wait -NoNewWindow
ENV PATH_WITH_SPACE2 "C:/Program Files/New Relic/newrelic-infra/"
COPY ./newrelic-infra.yml ${PATH_WITH_SPACE2}

# Download and Install URL Rewrite
ADD http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi /rewrite_amd64_en-US.msi
RUN Start-Process "msiexec.exe" -ArgumentList "/i","C:\\rewrite_amd64_en-US.msi","/qn","/norestart" -Wait -NoNewWindow
RUN Remove-Item -Path /rewrite_amd64_en-US.msi

# Download and Install StandaloneUI package
ADD https://downloads.izenda.com/$VERSION/StandaloneUI.zip ./StandaloneUI.zip
RUN Expand-Archive ./StandaloneUI.zip -dest C:\inetpub\wwwroot\ -force
RUN Remove-Item -Path ./StandaloneUI.zip

# Create website and bind
RUN Import-module IISAdministration; \
    New-IISSite -Name "web" -PhysicalPath C:\inetpub\wwwroot\StandaloneUI -BindingInformation "*:3000:"

# Download and Install New Relic APM
ADD https://download.newrelic.com/dot_net_agent/latest_release/newrelic-agent-win-8.5.186.0-scriptable-installer.zip /newrelic-agent-win-8.5.186.0-scriptable-installer.zip
RUN New-Item -ItemType directory -Path C:/newrelic-agent-win-8.5.186.0-scriptable-installer
COPY ./newrelicinstall.ps1 C:/
RUN ./newrelicinstall.ps1

# PUT web.config to the website
COPY ./Web.config C:/inetpub/wwwroot/StandaloneUI/
COPY ./index.html C:/inetpub/wwwroot/StandaloneUI/

# Update the API url in config file
RUN (Get-Content C:\inetpub\wwwroot\StandaloneUI\izenda_config.js).replace('http://192.168.45.37:8200/api/', 'http://172.100.0.3:3001/api/') \ 
    | Set-Content C:\inetpub\wwwroot\StandaloneUI\izenda_config.js

RUN iisreset

EXPOSE 3000
EXPOSE 80
EXPOSE 443
