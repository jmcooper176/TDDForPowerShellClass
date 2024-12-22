BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\ConvertModule.psd1'
    Import-Module -Name $ModulePath -Verbose
}

AfterAll {
    Get-Module -Name 'ConvertModule' | Remove-Module -Verbose
}

Describe -Name 'ConvertModule' {
    It 'should have a RootModule of ConvertModule.psm1' {
        # Arrange and Act
        $RootModule = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'RootModule'

        # Assert
        $RootModule | Should -Be 'ConvertModule.psm1'
    }

    It 'should have a ModuleVersion of 0.0.1' {
        # Arrange and Act
        $ModuleVersion = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'Version'
        
        # Assert
        $ModuleVersion | Should -Be '0.0.1'
    }

    It 'should have a GUID of def6571c-c831-4f02-85de-eda93d8841de' {
        # Arrange and Act
        $Guid = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'GUID'

        # Assert
        $Guid | Should -Be 'def6571c-c831-4f02-85de-eda93d8841de'
    }

    It 'should have an Author of John Merryweather Cooper' {
        # Arrange and Act
        $Author = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'Author'
        
        # Assert
        $Author | Should -Be 'John Merryweather Cooper'
    }

    It 'should have a CompanyName of Ram Tuned Mega Code' {
        # Arrange and Act
        $CompanyName = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
        # Assert
        $CompanyName | Should -Be 'Ram Tuned Mega Code'
    }

    It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
        # Arrange and Act
        $Copyright = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'Copyright'
        
        # Assert
        $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
    }

    It 'should have a Description of Collection of functions and cmdlets to do conversions.' {
        # Arrange and Act
        $Description = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'Description'

        # Assert
        $Description | Should -Be 'Collection of functions and cmdlets to do conversions.'
    }

    It 'should have a PowerShellVersion of 7.2' {
        # Arrange and Act
        $PowerShellVersion = Test-ModuleManifest -Path '.\ConvertModule.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

        # Assert
        $PowerShellVersion | Should -Be '7.2'
    }
}

Describe -Name 'ConvertFrom-Type' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path     = 'Function:\ConvertFrom-Type'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }
}

Describe -Name 'ConvertTo-Type' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path     = 'Function:\ConvertTo-Type'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }
}