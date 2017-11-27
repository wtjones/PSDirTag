
function Unregister-DirTagsPrompt {    
    [CmdletBinding()]
    param ()
    PROCESS {
        UnregisterDirTags
        if ($global:prompt_old -ne $null) {
            write-host 'Restoring old prompt...'
            set-content function:\global:prompt $global:prompt_old    
        }
    }
}
