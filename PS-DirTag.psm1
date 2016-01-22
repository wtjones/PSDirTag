param([parameter(Position=0, Mandatory = $false)][boolean]$debugMode = $false)

$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$configFilePath = join-path (split-path $profile -parent) 'dirtags.json'
$script:tagVariables = @()

# Dot source functions
"$moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath}


# Create a backup of the current prompt
#
if ((test-path function:\global:prompt) -and (get-content function:\prompt) -notlike '*PS-DirTags*') {
    if ($debugMode) {write-host 'Saving current prompt $global:prompt_old...'}
    $global:prompt_old = get-content function:\prompt    
}


#
# Override the powershell prompt to update the dirtags based on the pwd
#
function global:prompt {
    # Identifier line for PS-Dirtags. Do not remove.
    $realLASTEXITCODE = $LASTEXITCODE

    # Eat errors to avoid breaking the prompt.
    try {
        if ($debugMode) {
            UnregisterDirTags
            Register-DirTags -debugMode
            Register-WorkspaceTags -debugMode
        } else {
            Register-DirTags
            Register-WorkspaceTags
        }
    } catch [Exception]{
        if ($debugMode) { write-host $_.Message}
    }
   
    $global:LASTEXITCODE = $realLASTEXITCODE    
    return((& $global:prompt_old))
}

# Only functions with a dash are public
Export-ModuleMember -function *-*