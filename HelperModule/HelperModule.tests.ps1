BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'HelperModule.psd1' -Resolve
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

Describe -Name 'ConvertFrom-Type' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\ConvertFrom-Type'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context -Name 'Convert TypeAccelerators to FullNames' {
        It -Name 'Should return the FullName of the TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            Get-TypeAccelerator -ListAvailable | Select-Object -ExpandProperty Values  | ForEach-Object -Process {
                ConvertFrom-Type -Type $_ | Should -Be $_.FullName
            }
        }
    }
}

Describe -Name 'ConvertTo-Type' {
    Context -Name 'Exists' {
        It -Name 'Should exist' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                Path = 'Function:\ConvertTo-Type'
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }
    }

    Context -Name 'Convert FullNames to Types' {
        It -Name 'Should return the FullName of the TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            Get-TypeAccelerator -ListAvailable | Select-Object -ExpandProperty Keys  | ForEach-Object -Process {
                ConvertTo-Type -TypeName $_ | Should -Be ($_ -as [type])
            }
        }
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
            'Name' | Test-HasProperty -Object $Object -Strict | Should -BeTrue
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