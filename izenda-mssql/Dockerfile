FROM microsoft/mssql-server-windows-express

# Copy DB Files
COPY ./Izenda.mdf C:/Izenda.mdf
COPY ./Izenda_log.ldf C:/Izenda.ldf

# Download the NewRelic Infrastructure Monitor
ADD https://download.newrelic.com/infrastructure_agent/windows/newrelic-infra.msi /newrelic-infra.msi 
RUN Start-Process "msiexec.exe" -ArgumentList "/i","C:\\newrelic-infra.msi","/qn","/norestart" -Wait -NoNewWindow
ENV PATH_WITH_SPACE2 "C:/Program Files/New Relic/newrelic-infra/"
COPY ./newrelic-infra.yml ${PATH_WITH_SPACE2}

# Set SA password and Accepted EULA of using MSSQL Server
ENV sa_password=iZ3nd@_2018 
ENV ACCEPT_EULA=Y 
ENV attach_dbs='[{"dbName":"Izenda","dbFiles":["C:\\DATA\\Izenda.mdf","C:\\DATA\\Izenda_log.ldf"]}]'