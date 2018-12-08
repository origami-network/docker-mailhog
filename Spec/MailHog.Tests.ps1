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

        $logs = (& docker logs $containerId)
        Write-Host "== BEGIN: logs =="
        $logs |
            Write-Host
        Write-Host "== END: logs =="
    }

    $arguments = @(
        'inspect',
        '--format', '{{ .NetworkSettings.IPAddress }}',
        $containerId
    )
    Write-Host "> docker $($arguments -join ' ')"
    $containerHost = (& docker $arguments)

    It "accepts emails" {
        Write-Error "FIXME: implement case"
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
