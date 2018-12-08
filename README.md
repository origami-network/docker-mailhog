
| release | master | latest |
| :--: | :--: | :--: |
| TODO | [![master build](https://ci.appveyor.com/api/projects/status/7k4dybfrojw4ayvd/branch/master?svg=true)](https://ci.appveyor.com/project/BartDubois/docker-mailhog/branch/master) | [![latest build](https://ci.appveyor.com/api/projects/status/7k4dybfrojw4ayvd?svg=true)](https://ci.appveyor.com/project/BartDubois/docker-mailhog) |


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

By default the container will expose SMTP on TCP port 25.


### Sending email from PowerShell

In order to send the email the PowerShell [`Send-MailMessage`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/send-mailmessage) can be used.

```console
> Send-MailMessage -From 'sender@example.com' -To 'recipient@example.com' -Subject "From PowerShell" -SmtpServer <container address>
```

The `<container address>` is the IP address bind to the running instance.


## Contributing

In order to contribute to the project please fallow [Contributing Guidance](CONTRIBUTING.md).


## License

The project is licensed under [MIT License](LICENSE).
