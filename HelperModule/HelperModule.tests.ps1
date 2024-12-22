BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'HelperModule.psd1' -Resolve
    $ConvertModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\ConvertModule\ConvertModule.psd1' -Resolve
    $TypeAcceleratorPath = Join-Path -Path $PSScriptRoot -ChildPath '..\TypeAccelerator\TypeAccelerator.psd1' -Resolve
    
    # Act
    Import-Module -Name $ModulePath -Force -Verbose
    Import-Module -Name $TypeAcceleratorPath -Force -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -Not -BeNull
    Get-Module -Name 'TypeAccelerator' | Should -Not -BeNull
}

AfterAll {
    # Act
    Get-Module -Name 'HelperModule' | Remove-Module -Verbose
    Get-Module -Name 'TypeAccelerator' | Remove-Module -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -BeNull
    Get-Module -Name 'TypeAccelerator' | Should -BeNull
}

Describe -Name 'HelperModule' {
    It 'should have a RootModule of HelperModule.psm1' {
        # Arrange and Act
        $RootModule = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'RootModule'

        # Assert
        $RootModule | Should -Be 'HelperModule.psm1'
    }

    It 'should have a ModuleVersion of 1.1.0' {
        # Arrange and Act
        $ModuleVersion = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'Version'
        
        # Assert
        $ModuleVersion | Should -Be '1.1.0'
    }

    It 'should have a GUID of 196e2256-561c-4cdf-87dc-5146720c69c2' {
        # Arrange and Act
        $Guid = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'GUID'

        # Assert
        $Guid | Should -Be '196e2256-561c-4cdf-87dc-5146720c69c2'
    }

    It 'should have an Author of John Merryweather Cooper' {
        # Arrange and Act
        $Author = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'Author'
        
        # Assert
        $Author | Should -Be 'John Merryweather Cooper'
    }

    It 'should have a CompanyName of Ram Tuned Mega Code' {
        # Arrange and Act
        $CompanyName = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
        # Assert
        $CompanyName | Should -Be 'Ram Tuned Mega Code'
    }

    It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
        # Arrange and Act
        $Copyright = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'Copyright'
        
        # Assert
        $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
    }

    It 'should have a Description of Unit test helper functions for PowerShell.' {
        # Arrange and Act
        $Description = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'Description'

        # Assert
        $Description | Should -Be 'Unit test helper functions for PowerShell.'
    }

    It 'should have a PowerShellVersion of 5.1' {
        # Arrange and Act
        $PowerShellVersion = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

        # Assert
        $PowerShellVersion | Should -Be '5.1'
    }

    It 'should have a NestedModule of ConvertModule' {
        # Arrange and Act
        $NestedModules = Test-ModuleManifest -Path '.\HelperModule.psd1' | Select-Object -ExpandProperty 'NestedModules'

        # Assert
        $NestedModules | Should -Be 'ConvertModule'
    }
}

Describe -Name 'Select-ModuleByFilter' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Select-ModuleByFilter'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context -Name 'When the Module parameter exists and the Filter parameter is $true' {
        It -Name 'Should return the the same module' -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = $ModulePath

            # Act
            $Module = Select-ModuleByFilter -Path $Expected -Filter { $true }

            # Assert
            $Module | Select-Object -ExpandProperty Path | Should -Be $Expected
        }
    }
}

Describe -Name 'Select-ModuleByProperty' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Select-ModuleByProperty'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context -Name 'When the Module parameter exists and the Property parameter is "Path"' {
        It -Name 'Should return the the same module' -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = $ModulePath

            # Act
            $Module = Select-ModuleByProperty -Path $Expected -Property 'Path' -Value $Expected

            # Assert
            $Module | Select-Object -ExpandProperty Path | Should -Be $Expected
        }
    }
}

Describe 'Test-HasMember' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Test-HasMember'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context 'When the Object parameter is null' {
        It -Name 'Should throw a ArgumentNullException' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMember -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It -Name 'Should return $true' -Tag @('Unit', 'Test') {
            # Arrange
            $Object = Get-Item -LiteralPath $env:ComSpec

            # Act and Assert
            'FullName' | Test-HasMember -Object $Object -Strict | Should -BeTrue
        }
    }
}

Describe 'Test-HasMethod' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Test-HasMethod'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context 'When the Object parameter is null' {
        It -Name 'Should throw a ArgumentNullException' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMethod -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It -Name 'Should return $true' -Tag @('Unit', 'Test') {
            # Arrange
            $Object = Get-Item -LiteralPath $env:COMSPEC

            # Act and Assert
            'GetType' | Test-HasMethod -Object $Object -Strict | Should -BeTrue
        }
    }
}

Describe 'Test-HasProperty' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Test-HasMethod'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context 'When the Object parameter is null' {
        It -Name 'Should throw a ArgumentNullException' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMethod -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It -Name 'Should return $true' -Tag @('Unit', 'Test') {
            # Arrange
            $Object = [PSCustomObject]@{
                Name = 'John'
            }

            # Act and Assert
            $Object | Test-HasProperty -Object $Object -Strict | Should -BeTrue
        }
    }
}

Describe 'Test-ModuleProperty' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\Test-ModuleProperty'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context 'When the Module parameter exists and Property Name exists' {
        It -Name 'Should return $true' -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = 'Path'

            # Act and Assert
            $ModulePath | Test-ModuleProperty -Property $Expected | Should -BeTrue
        }
    }
}