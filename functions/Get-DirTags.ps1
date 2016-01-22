<#
    Formatted output of currently set dirtags.
#>
function Get-DirTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $result = @()

        foreach ($dt in $script:tagVariables) {
            $result += (@{name = '$' + $dt.name; path = $dt.path})
        }

        $result | %{
            new-object PSObject -Property @{name = $_.name; path = $_.path}
            } | ft -AutoSize
    }
}
