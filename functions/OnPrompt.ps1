<#
.SYNOPSIS
Wraps function calls made by the prompt function.
A cmdlet necessary in order to pass verbosity/debug scope.
#>
function OnPrompt {
    [CmdletBinding()]
    param ()
    PROCESS {
        UnregisterDirTags
        HandleHelpMessage        
        RegisterDirTags
        RegisterWorkspaceTags
    }
}