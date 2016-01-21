
function Get-DirTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $result = GetDirTagsConfig
        
        foreach ($dt in GetWorkspaceDirTags) {
            $result += (@{name = '$' + $dt.name; path = $dt.path})
        }

        $result | %{
            new-object PSObject -Property @{name = $_.name; path = $_.path}
            } | ft -AutoSize
    }
}
