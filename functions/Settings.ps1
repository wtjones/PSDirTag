
function Get-DirTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tagFile = join-path (split-path $profile -parent) '.dirtags'
        $tags = (get-content $tagFile -Raw) | ConvertFrom-Json
        return $tags.dirTags
    }
}


function Get-WorkspaceTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tagFile = join-path (split-path $profile -parent) '.dirtags'
        $tags = (get-content $tagFile -Raw) | ConvertFrom-Json
        return $tags.workspaceTags
    }
}
