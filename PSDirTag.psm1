param(
    # If set, the hooked prompt will call the main handler will the -Verbose flag
    [parameter(Position=0, Mandatory = $false)][boolean]
    $verbose = $false
)

$script:moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$script:configFileName = 'dirtags.json'
$script:configFilePath = join-path (split-path $profile -parent) $script:configFileName
$script:tagVariables = @()
$script:missingConfigMessageCount = 0

# Dot source functions
"$script:moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath}


# Create a backup of the current prompt
#
if ((test-path function:\global:prompt) -and (get-content function:\prompt) -notlike '*PSDirTag*') {    
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
        OnPrompt -Verbose:($verbose)        
    } catch [Exception]{
        $host.ui.WriteErrorLine($_.Exception.Message)
    }
   
    $global:LASTEXITCODE = $realLASTEXITCODE    
    return((& $global:prompt_old))
}

# Only functions with a dash are public
Export-ModuleMember -function *-*