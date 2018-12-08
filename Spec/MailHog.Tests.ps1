[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingCmdletAliases", "")]

param (
    [Parameter(Mandatory = $true)]
    $ImageName,

    $Here = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    $ModulesPath = (Join-Path $Here "Modules")
)

# TBD: what to import : Import-Module (Join-Path $ModulesPath 'TestDrive.psm1') -Force


Describe "MailHog image" {

    It "starts successfuly" {
        Write-Error "FIXME: implement case"
    }

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
}
