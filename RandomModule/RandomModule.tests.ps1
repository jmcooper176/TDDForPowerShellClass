BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\RandomModule.psd1'
    Import-Module -Name $ModulePath -Verbose
}

AfterAll {
    Get-Module -Name 'RandomModule' | Remove-Module -Verbose
}

Describe -Name 'RandomModule' {
    It 'should have a RootModule of RandomModule.psm1' {
        # Arrange and Act
        $RootModule = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'RootModule'

        # Assert
        $RootModule | Should -Be 'RandomModule.psm1'
    }

    It 'should have a ModuleVersion of 0.0.1' {
        # Arrange and Act
        $ModuleVersion = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'Version'
        
        # Assert
        $ModuleVersion | Should -Be '0.0.1'
    }

    It 'should have a GUID of c9b58d55-bc90-4b0a-943f-42b1ec7a9691' {
        # Arrange and Act
        $Guid = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'GUID'

        # Assert
        $Guid | Should -Be 'c9b58d55-bc90-4b0a-943f-42b1ec7a9691'
    }

    It 'should have an Author of John Merryweather Cooper' {
        # Arrange and Act
        $Author = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'Author'
        
        # Assert
        $Author | Should -Be 'John Merryweather Cooper'
    }

    It 'should have a CompanyName of Ram Tuned Mega Code' {
        # Arrange and Act
        $CompanyName = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
        # Assert
        $CompanyName | Should -Be 'Ram Tuned Mega Code'
    }

    It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
        # Arrange and Act
        $Copyright = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'Copyright'
        
        # Assert
        $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
    }

    It 'should have a Description of Cmdlets/functions for the generation of pseudo-random numbers.' {
        # Arrange and Act
        $Description = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'Description'

        # Assert
        $Description | Should -Be 'Cmdlets/functions for the generation of pseudo-random numbers.'
    }

    It 'should have a PowerShellVersion of 5.1' {
        # Arrange and Act
        $PowerShellVersion = Test-ModuleManifest -Path '.\RandomModule.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

        # Assert
        $PowerShellVersion | Should -Be '5.1'
    }
}