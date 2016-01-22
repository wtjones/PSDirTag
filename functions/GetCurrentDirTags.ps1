<#
    Returns Dirtags that exist based on current directory
#>
function GetCurrentDirTags() {
    $result = @()
    foreach($dt in GetDirTagsConfig) {

        $curPath = $pwd
        $foundPath = $null

        # Move up the directory tree until a match is found or root is reached.
        while ($foundPath -eq $null -and $curPath -ne '') {
            if (test-path (join-path $curPath $dt.path)) {
                $foundPath = (join-path $curPath $dt.path)
                if ($debugMode.IsPresent) {write-host ('found: ' + $foundPath)}
            } else {
                $curPath = (split-path $curPath)
            }
        }

        if ($foundPath -ne $null) {
            $tagPath = $foundPath
            $result += @{name = $dt.name; path = $dt.path}
        }        
    }
    return $result
}