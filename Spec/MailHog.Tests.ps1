[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingCmdletAliases", "")]

param (
    [Parameter(Mandatory = $true)]
    $ImageName,

    $Here = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    $ModulesPath = (Join-Path $Here "Modules")
)

# TBD: what to import : Import-Module (Join-Path $ModulesPath 'TestDrive.psm1') -Force


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

        Start-Sleep -Seconds 20

        $logs = & cmd /c "docker logs $containerId 2>&1"
        Write-Host "== BEGIN: logs =="
        $logs |
            Write-Host
        Write-Host "== END: logs =="
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

        It "is accessable" {
            Write-Error "FIXME: implement case"
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
