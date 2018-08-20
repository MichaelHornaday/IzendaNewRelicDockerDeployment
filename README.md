# Izenda Docker Images

Credit to Corey Robinson and Triet Pham for the base Izenda Docker script to be released soon

## Prerequisites

You need to install [Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows) and [switch to Windows containers](https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers)

## Getting Started

* Open each newrelic-infra.yml and newrelicinstall.ps1 file and set your New Relic License Key.
* Open the index.html file in the izenda-ui folder and add your New Relic Browser Agent JavaScript code.
* If you would like to use the Custom Attribute functionality you can remove the comments from the izenda-api folder's Dockerfile. You may need to build a custom version using another repo on this account called [NewRelicIzendaCustomAttributes](https://github.com/MichaelHornaday/IzendaNewRelicCustomAttributes).
* Navigate to root folder of this repo and run the following docker command (including build instruction - You may remove "-d --build" to just start the containers if the containers have already built).

```ps
docker-compose -f docker-compose.yml up -d --build
```

* After successfully started, open the Izenda BI web app in browser using the address http://172.100.0.5:3000
* Use the default Izenda adminstrator account to login and input the license/token key in the Settings page
  > Login Account: IzendaAdmin/IzendaAdmin123
