param([parameter(Position=0, Mandatory = $false)][boolean]$debugMode = $false)

$script:moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$script:configFileName = 'dirtags.json'
$script:configFilePath = join-path (split-path $profile -parent) $script:configFileName
$script:tagVariables = @()
$script:debugMode = $debugMode
$script:missingConfigMessageCount = 0

# Dot source functions
"$script:moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath}


# Create a backup of the current prompt
#
if ((test-path function:\global:prompt) -and (get-content function:\prompt) -notlike '*PSDirTag*') {
    if ($debugMode) {write-host 'Saving current prompt $global:prompt_old...'}
    $global:prompt_old = get-content function:\prompt    
}


#
# Override the powershell prompt to update the dirtags based on the pwd
#
function global:prompt {
    # Identifier line for PSDirTag. Do not remove.
    $realLASTEXITCODE = $LASTEXITCODE

    # Eat errors to avoid breaking the prompt.
    try {
        UnregisterDirTags
        HandleHelpMessage
        RegisterDirTags
        RegisterWorkspaceTags
    } catch [Exception]{
        if ($script:debugMode) { write-host $_.Message}
    }
   
    $global:LASTEXITCODE = $realLASTEXITCODE    
    return((& $global:prompt_old))
}

# Only functions with a dash are public
Export-ModuleMember -function *-*