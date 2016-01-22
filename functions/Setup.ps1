
function Unregister-DirTagsPrompt {    
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        UnregisterDirTags
        if ($global:prompt_old -ne $null) {
            write-host 'Restoring old prompt...'
            set-content function:\global:prompt $global:prompt_old    
        }
    }
}
