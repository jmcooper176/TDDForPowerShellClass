BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'HelperModule.psd1' -Resolve
    
    # Act
    Import-Module -Name $ModulePath -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -Not -BeNullOrEmpty
}

AfterAll {
    # Act
    Get-Module -Name 'HelperModule' | Remove-Module -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -BeNullOrEmpty
}

Describe -Name 'Select-ModuleByFilter' {
    Context -Name 'Exists' {
        It -Name 'Should exist' {
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
        It -Name 'Should return the the same module' {
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
        It -Name 'Should exist' {
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
        It -Name 'Should return the the same module' {
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
        It 'Should exist' {
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
        It 'Should throw a ArgumentNullException' {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMember -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It 'Should return $true' {
            # Arrange
            $Object = Get-Item -LiteralPath $env:ComSpec

            # Act and Assert
            'FullName' | Test-HasMember -Object $Object -Strict | Should -BeTrue
        }
    }
}

Describe 'Test-HasMethod' {
    Context -Name 'Exists' {
        It 'Should exist' {
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
        It 'Should throw a ArgumentNullException' {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMethod -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It 'Should return $true' {
            # Arrange
            $Object = Get-Item -LiteralPath $env:COMSPEC

            # Act and Assert
            'GetType' | Test-HasMethod -Object $Object -Strict | Should -BeTrue
        }
    }
}

Describe 'Test-HasProperty' {
    Context -Name 'Exists' {
        It 'Should exist' {
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
        It 'Should throw a ArgumentNullException' {
            # Arrange, Act, and Assert
            { 'Name' | Test-HasMethod -Object $null -Strict } | Should -Throw '*ArgumentNullException*'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It 'Should return $true' {
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
        It 'Should exist' {
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
        It 'Should return $true' {
            # Arrange
            $Expected = 'Path'

            # Act and Assert
            $ModulePath | Test-ModuleProperty -Property $Expected | Should -BeTrue
        }
    }
}