
function RegisterDirTags {
    foreach($dt in GetCurrentDirTags) {
        if ($script:debugMode) {write-host ('setting ${0} to {1}' -f $dt.name, $dt.path)}
        New-Variable $dt.name -Value $dt.path -Scope 'global' -Force
        $script:tagVariables += @{name = $dt.name; path = $dt.path}
    }
}
