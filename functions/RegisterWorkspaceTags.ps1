
function RegisterWorkspaceTags {
    foreach($wt in GetWorkspaceTagsConfig) {
        Write-Verbose ('creating workspace ${0} to {1}' -f $wt.name, $wt.path)
        New-Variable $wt.name -Value $wt.path -Scope 'global' -Force
        $script:tagVariables += @{name = $wt.name; path = $wt.path}
    }

    # Add relevant dirtags for each workspace. Example: $workspace1_sometag
    foreach($wt in GetWorkspaceDirTags) {
        New-Variable $wt.name -Value $wt.path -Scope 'global' -Force
        $script:tagVariables += @{name = $wt.name; path = $wt.path}
        Write-Verbose ('creating workspace dirtag ${0} to {1}' -f $wt.name, $wt.path)
    }
}

