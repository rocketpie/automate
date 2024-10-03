[CmdletBinding()]
Param(
    [string]$AutomateDirectory,
    [switch]$Clean
)

$directoryName = Split-Path -Leaf $AutomateDirectory
$imageName = "rocketpie/$($directoryName)"

if ($Clean) {
    $imageIdsToDelete = [System.Collections.ArrayList]::new()
    (docker images) | % {
        Write-Debug "searching docker image output '$($_)' for '$($imageName)'..."
        if ($_ -match "$($imageName) +(\w+) + (\w+) +") {
            Write-Debug "found image to delete: '$($Matches[2])'"
            $imageIdsToDelete.Add($Matches[2]) | Out-Null
        }
    }
    
    (docker ps -a) | % { 
        Write-Debug "searching docker ps output '$($_)'..."
        if ($_ -match '^(\w+) +([\w/]+) +') {
            $containerId = $Matches[1]
            $containerImage = $Matches[2]
            Write-Debug "found a container using image '$($containerImage)'"

            if ($containerImage -eq $imageName) {
                "deleting container '$($containerId)' running '$($imageName)'..."
                docker rm $Matches[1]
            }
                        
            foreach ($imageId in $imageIdsToDelete) {
                Write-Debug "searching for unnamed containers running '$($imageId)'..."
                if ($imageId.StartsWith($containerImage)) {                    
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
    
    "Done."
    return
}

docker build -t $imageName $AutomateDirectory 
"Done."