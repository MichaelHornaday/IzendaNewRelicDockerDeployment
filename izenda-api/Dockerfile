FROM microsoft/aspnet

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

# Download and Install Visual C++ 2010 Redistributable
ADD https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe /vcredist_x86.exe
RUN C:\vcredist_x86.exe /quiet /install
RUN Remove-Item -Path /vcredist_x86.exe

ADD https://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe /vcredist_x64.exe
RUN C:\vcredist_x64.exe /quiet /install
RUN Remove-Item -Path /vcredist_x64.exe

# Download and Install API package
ADD https://downloads.izenda.com/$VERSION/API.zip ./API.zip
RUN Expand-Archive ./API.zip -dest C:\inetpub\wwwroot\ -force
RUN Remove-Item -Path ./API.zip

# Create website and bind
RUN Import-module IISAdministration; \
    New-IISSite -Name "api" -PhysicalPath C:\inetpub\wwwroot\API -BindingInformation "*:3001:"

# Download and Install New Relic APM
ADD https://download.newrelic.com/dot_net_agent/latest_release/newrelic-agent-win-8.5.186.0-scriptable-installer.zip /newrelic-agent-win-8.5.186.0-scriptable-installer.zip
RUN New-Item -ItemType directory -Path C:/newrelic-agent-win-8.5.186.0-scriptable-installer
COPY ./newrelicinstall.ps1 C:/
RUN ./newrelicinstall.ps1

# Update the config
COPY ./Web.config C:/inetpub/wwwroot/API/
COPY ./izendadb.config C:/inetpub/wwwroot/API/

# Add DLLs for Custom Attributes
# COPY ./CustomAdhocReports.dll C:/inetpub/wwwroot/API/bin/
# COPY ./NewRelic.Api.Agent.dll C:/inetpub/wwwroot/API/bin/

RUN iisreset

EXPOSE 3001
EXPOSE 80
EXPOSE 443