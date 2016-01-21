
function GetDirTagsConfig {
    $tags = (get-content $configFilePath -Raw) | ConvertFrom-Json
    return $tags.dirTags

}


function GetWorkspaceTagsConfig {
    $tags = (get-content $configFilePath -Raw) | ConvertFrom-Json
    return $tags.workspaceTags

}
