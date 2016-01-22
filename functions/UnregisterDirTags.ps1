<#
    Clean up any variables that were created as dirtags
#>
function UnregisterDirtags() {
    foreach($var in $script:tagVariables) {
        if ($debugMode) {write-host ('removing variable ${0}' -f $var.name)}
        Remove-Variable $var.name -Force
    }
    $script:tagVariables = @()
}
