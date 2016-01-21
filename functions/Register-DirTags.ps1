
function Register-DirTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        foreach($dt in GetCurrentDirTags) {
            if ($debugMode.IsPresent) {write-host ('setting ${0} to {1}' -f $dt.name, $dt.path)}
            New-Variable $dt.name -Value $dt.path -Scope 'global' -Force
        }
    }
}

