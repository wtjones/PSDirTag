<#
    Output a helpfull message if appropriate
#>
function HandleHelpMessage() {
    if ($script:missingConfigMessageCount -eq 0) {
        if (!(Test-Path $script:configFilePath)) {
            
            Import-LocalizedData -basedirectory $script:moduleRoot -filename 'PS-DirTag.psd1' -bindingvariable manifest
            $projectUri = $manifest.PrivateData.PSData.ProjectUri
            write-host "PS-DirTag: A config file was not found at $script:configFilePath"
            write-host "           Please see project page for examples: $projectUri"

            $script:missingConfigMessageCount += 1
        }
    }
}