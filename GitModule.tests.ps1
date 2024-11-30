BeforeAll {
    # Arrange
    $BaseName        = Get-Item -LiteralPath $PSCommandPath | Select-Object -ExpandProperty BaseName
    $BaseName        = $BaseName -replace '\.tests$'
    $ModuleUnderTest = Join-Path -Path $PSScriptRoot -ChildPath "$BaseName.psd1" -Resolve
    
    # Act
    Import-Module -Name $ModuleUnderTest -Verbose

    # Mock for Invoke-GitCommit
    function Invoke-GitCommit {
        param (
            [Parameter(Mandatory, ValueFromPipeline)]
            [string]
            $Message,

            [switch]
            $All
        )

        if ($All.IsPresent) {
            Write-Host -Object "All -> $Message"
        }
        else {
            Write-Host -Object "Interactive -> $Message"
        }
    }

    # Assert
    Get-Module -Name $BaseName | Should -Not -BeNullOrEmpty
}

AfterAll {
    # Act
    Get-Module -ListAvailable | Where-Object -Property Name -EQ $ModuleUnderTest | Remove-Module -Verbose

    # Assert
    Get-Module -ListAvailable | Where-Object -Property Name -EQ $ModuleUnderTest | Should -BeNullOrEmpty
}

Describe -Name 'Git Message Test Suite' -Tag 'Test Suite' {
    Describe -Name 'Function Invoke-GitCommit' -Tag 'Unit Tests' {
        Context -Name 'Exists' {
            It -Name 'Should exist' -Tag 'Unit Test' {
                # Arrange
                $testPathSplat = @{
                    LiteralPath = 'Function:\Invoke-GitCommit'
                    PathType = 'Leaf'
                }

                # Act and Assert
                Test-Path @testPathSplat | Should -Not -BeNullOrEmpty
            }
        }

        Context -Name 'Mocking Modes of Invoke-GitCommit' {
            BeforeEach {
                Mock -CommandName 'Invoke-GitCommit' -MockWith {
                    Write-Host -Object 'Mocked -Interactive -> $($Message)'
                }
            }

            It -Name 'Should invoke interactive commit' -Tag 'Unit Test' {
                # Arrange
                $Message = "test #1 (local):  test commit message with $($Interactive.IsPresent)"

                # Act and Assert
                $Message | Invoke-GitCommit | Should -InvokeVerifiable
            }
        }

        Context -Name 'Mocking Modes of Invoke-GitCommit All' {
            BeforeEach {
                Mock -CommandName 'Invoke-GitCommit' -MockWith {
                    Write-Host -Object 'Mocked -All -> $($Message)'
                }
            }

            It -Name 'Should invoke commit all' -Tag 'Unit Test' {
                # Arrange
                $Message = "test #1 (local):  test commit message with $($All.IsPresent)"

                # Act and Assert
                $Message | Invoke-GitCommit -All | Should -InvokeVerifiable
            }
        }
    }

    Describe -Name 'Function Write-Header' -Tag 'Unit Tests' {
        Context -Name 'Exists' {
            It -Name 'Should exist' -Tag 'Unit Test' {
                 # Arrange
                 $testPathSplat = @{
                    LiteralPath = 'Function:\Write-Header'
                    PathType = 'Leaf'
                }

                # Act and Assert
                Test-Path @testPathSplat | Should -Not -BeNullOrEmpty
            }
        }

        Context -'Header -le 50 characters long' {
            It -Name 'Bug template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'bug' -Id '1234' -Scope 'local' -Title 'Fixing a bug'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'Epic template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'epic' -Id '1234' -Scope 'local' -Title 'Creating an epic'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'Feature template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'feature' -Id '1234' -Scope 'local' -Title 'Adding a feature'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'Issue template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'issue' -Id '1234' -Scope 'local' -Title 'Resolving an epic'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'Task template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'task' -Id '1234' -Scope 'local' -Title 'Completing a task'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'Test Case template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'test case' -Id '1234' -Scope 'local' -Title 'Testing a test case'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }

            It -Name 'User Story template should be less than or equal to 50 characters' -Tag 'Unit Test' {
                # Arrange

                # Act
                $header = Write-Header -Type 'user story' -Id '1234' -Scope 'local' -Title 'Writing a user story'

                # Assert
                $header.Length | Should -BeLessOrEqual 50
            }
        }
    }

    Describe -Name 'Function Write-Body' -Tag 'Unit Tests' {
        Context -Name 'Exists' {
            It -Name 'Should exist' -Tag 'Unit Test' {
                 # Arrange
                 $testPathSplat = @{
                    LiteralPath = 'Function:\Write-Body'
                    PathType = 'Leaf'
                }

                # Act and Assert
                Test-Path @testPathSplat | Should -Not -BeNullOrEmpty
            }
        }
    }

    Describe -Name 'Function Write-Footer' -Tag 'Unit Tests' {
        Context -Name 'Exists' {
            It -Name 'Should exist' -Tag 'Unit Test' {
                 # Arrange
                 $testPathSplat = @{
                    LiteralPath = 'Function:\Write-Footer'
                    PathType = 'Leaf'
                }

                # Act and Assert
                Test-Path @testPathSplat | Should -Not -BeNullOrEmpty
            }
        }
    }
}