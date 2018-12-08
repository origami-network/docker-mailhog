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

function Get-DockerNetworksIpAddress {
    param (
        $Id
    )
    
    & docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $Id
}

function Remove-Docker {
    param (
        $Id,
        [switch] $Force
    )

    $script:arguments = @('rm')
    if ($Force) {
        $script:arguments += @('--force')
    }
    $script:arguments += @($Id)

    & docker $script:arguments
}


Describe "MailHog image" {

    $arguments = @(
        'run', '-d'
        $ImageName
    )
    Write-Host "> docker $($arguments -join ' ')"
    $containerId = (& docker $arguments)
    $containerAddress = Get-DockerNetworksIpAddress $containerId


    It "starts successfuly" {
        $LASTEXITCODE |
            Should -Be 0

        # TODO: make it non blocking, wait for corect value for 1 minute
        Start-Sleep -Seconds 20
        $logs = Get-DockerLogs $containerId
        Write-Host "== BEGIN: docker logs =="
        $logs |
            Write-Host
        Write-Host "== END: docker logs =="

        $logs |
            ? {$_ -like '*Serving under*'} |
            Should -HaveCount 1
    }
    
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

        # FIXME: use port 80 
        $baseUrl = "http://$($containerAddress):8025/api/"

        It "exposess accepted emails" {
            $from = "$( [guid]::NewGuid().ToString('d') )@example.com"
            Send-MailMessage -From $from -To 'recipient@example.com' -Subject 'Test' -SmtpServer $containerAddress

            $response = Invoke-RestMethod ($baseUrl + "v2/search?kind=from&query=$($from)")

            $response.total |
                Should -Be 1
        }

        It "allows to remove accepted emails" {
            @(1..10) |
                % { Send-MailMessage -From 'sender@example.com' -To "recipient-$($_)@example.com" -Subject "Test $($_)" -SmtpServer $containerAddress }

            Invoke-RestMethod ($baseUrl + "v1/messages") -Method Delete |
                Out-Null

            $response = Invoke-RestMethod ($baseUrl + "v2/messages")
            $response.total |
                Should -Be 0            
        }
    }


    Remove-Docker($containerId)
}
