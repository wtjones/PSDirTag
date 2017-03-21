$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleRoot = "$here\.."


"$moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath; write-host $_.ProviderPath}
. "$here\TestSetup.ps1"


Describe "GetDirTagsConfig" {
    Setup-TestData
    $result = GetDirTagsConfig
    It "doesn't throw" {        
        write-host $result
        $true | Should Be $true
    }

    It "has results" {
        write-host $result
        $result.length | Should Not Be 0
    }
}

Describe "GetDirTagsConfig with no config" {
    Setup-NoTestData
    $result = GetDirTagsConfig
    It "doesn't throw" {        
        write-host $result
        $true | Should Be $true
    }

    It "shouldn't return null" {
        write-host $result
        $result.length | Should Be 0
    }
}

Describe "GetWorkspaceTagsConfig" {
    Setup-TestData
    $result = GetWorkspaceTagsConfig
    It "doesn't throw" {        
        write-host $result
        $true | Should Be $true
    }

    It "has results" {
        write-host $result
        $result.length | Should Not Be 0
    }
}

Describe "GetWorkspaceTagsConfig with no config" {
    Setup-NoTestData
    $result = GetWorkspaceTagsConfig
    It "doesn't throw" {        
        write-host $result
        $true | Should Be $true
    }

    It "shouldn't return null" {
        write-host $result
        $result.length | Should Be 0
    }
}

