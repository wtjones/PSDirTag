
function Register-WorkspaceTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {        
        foreach($wt in GetWorkspaceTagsConfig) {
            if ($debugMode.IsPresent) {write-host ('creating workspace ${0} to {1}' -f $wt.name, $wt.path)}
            New-Variable $wt.name -Value $wt.path -Scope 'global' -Force
        }

        # Add relevant dirtags for each workspace. Example: $workspace1_sometag
        foreach($wt in GetWorkspaceDirTags) {
            New-Variable $wt.name -Value $wt.path -Scope 'global' -Force
            if ($debugMode.IsPresent) {write-host ('creating workspace dirtag ${0} to {1}' -f $wt.name, $wt.path)}
        }
    }
}

