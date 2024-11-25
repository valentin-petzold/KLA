function Build-DockerImage {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Dockerfile,

        [Parameter(Mandatory = $true)]
        [string]$Tag,

        [Parameter(Mandatory = $true)]
        [string]$Context,

        [string]$ComputerName
    )
    if ($ComputerName) {
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker build -t $using:Tag -f $using:Dockerfile $using:Context
        }
    } else {
        docker build -t $Tag -f $Dockerfile $Context
    }
}

function Copy-Prerequisites {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ComputerName,

        [Parameter(Mandatory = $true)]
        [string[]]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Destination
    )
    foreach ($p in $Path) {
        $destinationPath = "\\$ComputerName\$($Destination -replace '^[A-Za-z]:', '')"
        Copy-Item -Path $p -Destination $destinationPath -Recurse -Force
    }
}

function Run-DockerContainer {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ImageName,

        [string]$ComputerName,

        [string[]]$DockerParams
    )
    $params = $DockerParams -join ' '
    if ($ComputerName) {
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker run $using:params $using:ImageName
        } -OutVariable containerName
    } else {
        $containerName = docker run $params $ImageName
    }
    return $containerName.Trim()
}

Export-ModuleMember -Function Build-DockerImage, Copy-Prerequisites, Run-DockerContainer
