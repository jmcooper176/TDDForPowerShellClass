BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\MessageModule.psd1'
    Import-Module -Name $ModulePath -Verbose
}

AfterAll {
    Get-Module -Name 'MessageModule' | Remove-Module -Verbose
}

Describe -Name 'MessageModule' {
    It 'should have a RootModule of MessageModule.psm1' {
        # Arrange and Act
        $RootModule = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'RootModule'

        # Assert
        $RootModule | Should -Be 'MessageModule.psm1'
    }

    It 'should have a ModuleVersion of 0.0.1' {
        # Arrange and Act
        $ModuleVersion = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'Version'
        
        # Assert
        $ModuleVersion | Should -Be '0.0.1'
    }

    It 'should have a GUID of 70f1f86a-28b1-48a2-8f3e-34c5c8363091' {
        # Arrange and Act
        $Guid = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'GUID'

        # Assert
        $Guid | Should -Be '70f1f86a-28b1-48a2-8f3e-34c5c8363091'
    }

    It 'should have an Author of John Merryweather Cooper' {
        # Arrange and Act
        $Author = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'Author'
        
        # Assert
        $Author | Should -Be 'John Merryweather Cooper'
    }

    It 'should have a CompanyName of Ram Tuned Mega Code' {
        # Arrange and Act
        $CompanyName = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
        # Assert
        $CompanyName | Should -Be 'Ram Tuned Mega Code'
    }

    It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
        # Arrange and Act
        $Copyright = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'Copyright'
        
        # Assert
        $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
    }

    It 'should have a Description of Cmdlets/functions to format and write messages.' {
        # Arrange and Act
        $Description = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'Description'

        # Assert
        $Description | Should -Be 'Cmdlets/functions to format and write messages.'
    }

    It 'should have a PowerShellVersion of 5.1' {
        # Arrange and Act
        $PowerShellVersion = Test-ModuleManifest -Path '.\MessageModule.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

        # Assert
        $PowerShellVersion | Should -Be '5.1'
    }
}