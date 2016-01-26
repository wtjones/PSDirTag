
function GetDirTagsConfig {
    $tags = (get-content $script:configFilePath -Raw) | ConvertFrom-Json
    return $tags.dirTags

}


function GetWorkspaceTagsConfig {
    $tags = (get-content $script:configFilePath -Raw) | ConvertFrom-Json
    return $tags.workspaceTags

}
