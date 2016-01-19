
function Get-DirTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tags = (get-content $configFilePath -Raw) | ConvertFrom-Json
        return $tags.dirTags
    }
}


function Get-WorkspaceTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tags = (get-content $configFilePath -Raw) | ConvertFrom-Json
        return $tags.workspaceTags
    }
}
