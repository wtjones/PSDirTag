param([parameter(Position=0, Mandatory = $false)][boolean]$debugMode = $false)


function Get-DirTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tagFile = join-path (split-path $profile -parent) '.dirtags'
        $tags = (get-content $tagFile -Raw) | ConvertFrom-Json
        return $tags.dirTags
    }
}


function Get-WorkspaceTags {
    [CmdletBinding()]
    param ()
    PROCESS {
        $tagFile = join-path (split-path $profile -parent) '.dirtags'
        $tags = (get-content $tagFile -Raw) | ConvertFrom-Json
        return $tags.workspaceTags
    }
}



function Register-DirTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        foreach($dt in Get-DirTags) {

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
            } else {        
                $tagPath = $dt.path
            }
            
            if (test-path ('variable:\' + $dt.name)) {
                if ($debugMode.IsPresent) {write-host ('setting {0} to {1}' -f $dt.name, $tagPath)}
                Set-Variable $dt.name -Value $tagPath -Scope 'global'    
            } else {
                if ($debugMode.IsPresent) {write-host ('creating {0} to {1}' -f $dt.name, $tagPath)}
                New-Variable $dt.name -Value $tagPath -Scope 'global'
            }
            
        }
    }
}



function Register-WorkspaceTags {
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        foreach($wt in Get-WorkspaceTags) {
            if (test-path ('variable:\' + $dt.name)) {
                if ($debugMode.IsPresent) {write-host ('setting {0} to {1}' -f $wt.name, $wt.path)}
                Set-Variable $wt.name -Value $wt.path -Scope 'global'
            } else {
                if ($debugMode.IsPresent) {write-host ('creating {0} to {1}' -f $wt.name, $wt.path)}
                New-Variable $wt.name -Value $wt.path -Scope 'global'
            }

            foreach($dt in Get-DirTags) {
                if (test-path (join-path $wt.path $dt.path)) {
                    $tagName = ('{0}_{1}' -f $wt.name, $dt.name)
                    $tagPath = (join-path $wt.path $dt.path)
                    if (test-path ('variable:\' + $tagName)) {
                        if ($debugMode.IsPresent) {write-host ('setting {0} to {1}' -f $tagName, $tagPath)}
                        Set-Variable $tagName -Value $tagPath -Scope 'global'
                     } else {
                        if ($debugMode.IsPresent) {write-host ('creating {0} to {1}' -f $tagName, $tagPath)}
                        New-Variable $tagName -Value $tagPath -Scope 'global'
                    }
                }
            }

        }
    }
}



function Unregister-DirTagsPrompt {    
    [CmdletBinding()]
    param ([switch]$debugMode)
    PROCESS {
        if ($global:prompt_old -ne $null) {
            write-host 'Restoring old prompt...'
            set-content function:\global:prompt $global:prompt_old    
        }
    }
}

#
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

Export-ModuleMember -function *-*