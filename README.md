
| release | master | latest |
| :--: | :--: | :--: |
| [![latest release](https://img.shields.io/github/release/origami-network/docker-mailhog.svg)](https://github.com/origami-network/docker-mailhog/releases/latest) | [![master build](https://ci.appveyor.com/api/projects/status/7k4dybfrojw4ayvd/branch/master?svg=true)](https://ci.appveyor.com/project/BartDubois/docker-mailhog/branch/master) | [![latest build](https://ci.appveyor.com/api/projects/status/7k4dybfrojw4ayvd?svg=true)](https://ci.appveyor.com/project/BartDubois/docker-mailhog) |


| pulls | stars |
| :--: | :--: |
| [![Docker Pulls](https://img.shields.io/docker/pulls/origaminetwork/mailhog.svg)](https://hub.docker.com/r/origaminetwork/plantuml/) | [![Docker Stars](https://img.shields.io/docker/stars/origaminetwork/mailhog.svg)](https://hub.docker.com/r/origaminetwork/plantuml/) |


MailHog - Windows Docker image
==

[MailHog](https://github.com/mailhog/MailHog) is an email testing tool for developers.
Provides SMTP server, with web or API access.


## Usage

This Docker image allows to use MailHog without need of installation on Windows 2016 and Windows 10.
It accepts all parameters as specified by [Configuring MailHog](https://github.com/mailhog/MailHog/blob/master/docs/CONFIG.md) document.


### Pull Docker image

Before start the image need to be pulled from the [Docker Hub](https://hub.docker.com/r/origaminetwork/mailhog/).

```console
> docker pull origaminetwork/mailhog:X.X.X.Y
```

Where `X.X.X.Y` is the version of the image.

By default the container will expose:
 - SMTP on TCP port 25,
 - Web UI at URL `http://<container address>/`,
 - Web API at URL `http://<container address>/api`).

The `<container address>` is the IP address bind to the running instance.


### Sending email from PowerShell

In order to send the email the PowerShell [`Send-MailMessage`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/send-mailmessage) can be used.

```console
PS> Send-MailMessage -From 'sender@example.com' -To 'recipient@example.com' -Subject "From PowerShell" -SmtpServer <container address>
```

The `<container address>` is the IP address bind to the running instance.


### Getting mails using API

In order to get mails received by the server the fallowing PowerShell command can be used.

```console
PS> $baseUrl = 'http://<container address>/api/'
PS> Invoke-RestMethod ($baseUrl + "v2/messages")
```

The `<container address>` is the IP address bind to the running instance.


## Contributing

In order to contribute to the project please fallow [Contributing Guidance](CONTRIBUTING.md).


## License

The project is licensed under [MIT License](LICENSE).
