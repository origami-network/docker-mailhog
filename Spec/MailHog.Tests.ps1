[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingCmdletAliases", "")]

param (
    [Parameter(Mandatory = $true)]
    $ImageName,

    $Here = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    $ModulesPath = (Join-Path $Here "Modules")
)

# TBD: what to import : Import-Module (Join-Path $ModulesPath 'TestDrive.psm1') -Force

function Get-DockerLogs {
    param (
        $Id
    )
    
    & cmd /c "docker logs $containerId 2>&1"
}

Describe "MailHog image" {

    $arguments = @(
        'run', '-d'
        $ImageName
    )
    Write-Host "> docker $($arguments -join ' ')"
    $containerId = (& docker $arguments)


    It "starts successfuly" {
        $LASTEXITCODE |
            Should -Be 0

        # TODO: make it non blocking, wait for corect value for 1 minute
        Start-Sleep -Seconds 20
        $logs = & cmd /c "docker logs $containerId 2>&1"
        Write-Host "== BEGIN: docker logs =="
        $logs |
            Write-Host
        Write-Host "== END: docker logs =="

        $logs |
            ? {$_ -like '*Serving under*'} |
            Should -HaveCount 1
    }

    $arguments = @(
        'inspect',
        '--format', '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}',
        $containerId
    )
    Write-Host "> docker $($arguments -join ' ')"
    $containerAddress = (& docker $arguments)

    It "accepts emails" {
        Send-MailMessage -From 'sender@example.com' -To 'recipient@example.com' -Subject "Test" -SmtpServer $containerAddress
    }

    Context "Web UI" {

        # FIXME: use port 80 
        $baseUrl = "http://$($containerAddress):8025/"

        It "is accessable" {
            $response = Invoke-WebRequest $baseUrl -UseBasicParsing

            $response.StatusCode |
                Should -Be 200
            $response.Content |
                Should -BeLike '*<title>MailHog</title>*'
        }
    }

    Context "Web API" {

        It "exposess accepted emails" {
            Write-Error "FIXME: implement case"
        }

        It "allows to remove accepted emails" {
            Write-Error "FIXME: implement case"
        }
    }


    $arguments = @(
        'rm',
        '--force',
        '--volumes',
        $containerId
    )
    Write-Host "> docker $($arguments -join ' ')"
    $containerId = (& docker $arguments)
}
