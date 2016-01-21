<#
    Returns dirtags that exist in each workspace. Example: $workspace1_sometag
#>
function GetWorkspaceDirTags() {
    $result = @()
	foreach($wt in GetWorkspaceTagsConfig) {
        foreach($dt in GetDirTagsConfig) {
            if (test-path (join-path $wt.path $dt.path)) {
                $tagName = ('{0}_{1}' -f $wt.name, $dt.name)
                $tagPath = (join-path $wt.path $dt.path)
                $result += @{'name' = $tagName; 'path' = $tagPath; 'workspace' = $wt.name}
            }
        }
    }
    return $result
}