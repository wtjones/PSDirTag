
function Register-WorkspaceTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        foreach($wt in Get-WorkspaceTags) {            
            if ($debugMode.IsPresent) {write-host ('creating {0} to {1}' -f $wt.name, $wt.path)}
            New-Variable $wt.name -Value $wt.path -Scope 'global' -Force
            
            foreach($dt in Get-DirTags) {
                if (test-path (join-path $wt.path $dt.path)) {
                    $tagName = ('{0}_{1}' -f $wt.name, $dt.name)
                    $tagPath = (join-path $wt.path $dt.path)
                    if ($debugMode.IsPresent) {write-host ('setting {0} to {1}' -f $tagName, $tagPath)}
                    New-Variable $tagName -Value $tagPath -Scope 'global' -Force
                    
                }
            }

        }
    }
}

