
function Register-DirTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        foreach($dt in Get-DirTags) {

            $curPath = $pwd
            $foundPath = $null

            # Move up the directory tree until a match is found or root is reached.
            while ($foundPath -eq $null -and $curPath -ne '') {
                if (test-path (join-path $curPath $dt.path)) {
                    $foundPath = (join-path $curPath $dt.path)
                    if ($debugMode.IsPresent) {write-host ('found: ' + $foundPath)}
                } else {
                    $curPath = (split-path $curPath)
                }
            }

            if ($foundPath -ne $null) {
                $tagPath = $foundPath
            } else {        
                $tagPath = $dt.path
            }
                        
            if ($debugMode.IsPresent) {write-host ('setting ${0} to {1}' -f $dt.name, $tagPath)}
            New-Variable $dt.name -Value $tagPath -Scope 'global' -Force
            
        }
    }
}

