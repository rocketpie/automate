[CmdletBinding()]
Param(
    [string]$AutomateDirectory,
    [switch]$Clean
)

$directoryName = Split-Path -Leaf $AutomateDirectory
$imageName = "rocketpie/$($directoryName)"

if ($Clean) {
    $imageIdsToDelete = [System.Collections.ArrayList]::new()
    docker images | % {
        if ($_ -match "$($imageName) +(\w+) + (\w+) +") {
            $imageIdsToDelete.Add($Matches[2]) | Out-Null
        }
    }
    
    docker ps -a | % { 
        if ($_ -match '^(\w+) +(\w+) +') {
            if ($Matches -eq 'container') { continue }
            foreach ($imageId in $imageIdsToDelete) {
                if ($imageId.StartsWith($Matches[2])) {
                    $containerId = $Matches[1]
                    "deleting container '$($containerId)'"
                    docker rm $containerId
                }
            }            
        }
    }

    foreach ($imageId in $imageIdsToDelete) {
        "deleting image '$($imageId)'"
        docker rmi $imageId
    }
    
    return
}

docker build -t $imageName $AutomateDirectory 