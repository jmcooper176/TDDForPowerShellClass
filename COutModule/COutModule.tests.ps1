BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\COutModule.psd1'
    Import-Module -Name $ModulePath
}

AfterAll {
    Get-Module -Name 'COutModule' | Remove-Module
}

Describe -Name 'COutModule' {
    It 'should have a RootModule of COutModule.psm1' {
        # Arrange and Act
        $RootModule = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'RootModule'

        # Assert
        $RootModule | Should -Be 'COutModule.psm1'
    }

    It 'should have a ModuleVersion of 0.0.1' {
        # Arrange and Act
        $ModuleVersion = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'Version'
        
        # Assert
        $ModuleVersion | Should -Be '0.0.1'
    }

    It 'should have a GUID of 4f5a8f36-f1ac-4fbf-9257-614fb7d06278' {
        # Arrange and Act
        $Guid = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'GUID'

        # Assert
        $Guid | Should -Be '4f5a8f36-f1ac-4fbf-9257-614fb7d06278'
    }

    It 'should have an Author of John Merryweather Cooper' {
        # Arrange and Act
        $Author = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'Author'
        
        # Assert
        $Author | Should -Be 'John Merryweather Cooper'
    }

    It 'should have a CompanyName of Ram Tuned Mega Code' {
        # Arrange and Act
        $CompanyName = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
        # Assert
        $CompanyName | Should -Be 'Ram Tuned Mega Code'
    }

    It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
        # Arrange and Act
        $Copyright = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'Copyright'
        
        # Assert
        $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
    }

    It 'should have a Description of Collection of functions and cmdlets to do conversions.' {
        # Arrange and Act
        $Description = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'Description'

        # Assert
        $Description | Should -Be 'Functions/Cmdlets to write to stdout/stderr.'
    }

    It 'should have a PowerShellVersion of 5.1' {
        # Arrange and Act
        $PowerShellVersion = Test-ModuleManifest -Path '.\COutModule.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

        # Assert
        $PowerShellVersion | Should -Be '5.1'
    }
}