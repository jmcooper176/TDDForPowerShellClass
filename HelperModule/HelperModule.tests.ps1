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
            { Test-HasMethod -Object $null -Name 'Name' -Strict } | Should -Throw 'System.ArgumentNullException'
        }
    }

    Context 'When the Object parameter is not null and Property Name exists' {
        It 'Should return $true' {
            # Arrange
            $Object = [PSCustomObject]@{
                Name = 'John'
            }

            # Act and Assert
            Test-HasProperty -Object $Object -Name 'Name' -Strict | Should -BeTrue
        }
    }
}