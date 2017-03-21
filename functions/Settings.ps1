
function GetDirTagsConfig {
    $result = @()
    if (test-path $script:configFilePath) {
        $tags = (get-content $script:configFilePath -Raw) | ConvertFrom-Json
        $result = $tags.dirTags
    }
    return $result
}


function GetWorkspaceTagsConfig {
    $result = @()
    if (test-path $script:configFilePath) {
        $tags = (get-content $script:configFilePath -Raw) | ConvertFrom-Json
        $result = $tags.workspaceTags
    }
    return $result
}