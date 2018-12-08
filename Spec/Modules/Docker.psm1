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
