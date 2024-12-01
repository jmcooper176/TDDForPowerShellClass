using module .\Vine.psm1

<#
    Vine Pester Tests Based on the Pester Framework and STL Any Class

    https://learn.microsoft.com/en-us/cpp/standard-library/any-class?view=msvc-170#members
#>

BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\Vine.psd1' -Resolve
    $HelperModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\HelperModule\HelperModule.psd1' -Resolve

    Set-Variable -Name TheAnswer -Option Constant -Value 42
    Set-Variable -Name LuckyNumber -Option Constant -Value 7
    Set-Variable -Name UnluckyNumber -Option Constant -Value 13

    $TestData = @(
        [PSCustomObject]@{Name = 'NormalAnswer'; Value = $TheAnswer; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'NormalLucky'; Value = $LuckyNumber; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'NormalUnlucky'; Value = $UnluckyNumber; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'LongAnswer'; Value = [Int64]$TheAnswer; Type = [type][Int64];},
        [PSCustomObject]@{Name = 'LongLucky'; Value = [Int64]$LuckyNumber; Type = [type][Int64];},
        [PSCustomObject]@{Name = 'LongUnlucky'; Value = [Int64]$UnluckyNumber; Type = [type][Int64];},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [decimal].AsType();},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [decimal].AsType();},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [decimal].AsType();},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [double].AsType();},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [double].AsType();},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [double].AsType();},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [Single].AsType();},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [Single].AsType();},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [Single].AsType();},
        [PSCustomObject]@{Name = 'NegativeAnswer'; Value = -$TheAnswer; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'NegativeLucky'; Value = -$LuckyNumber; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'NegativeUnlucky'; Value = -$UnluckyNumber; Type = [type][Int32];},
        [PSCustomObject]@{Name = 'StringAnswer'; Value = [string]$TheAnswer; Type = [string].AsType();},
        [PSCustomObject]@{Name = 'StringLucky'; Value = [string]$LuckyNumber; Type = [string].AsType();},
        [PSCustomObject]@{Name = 'StringUnlucky'; Value = [string]$UnluckyNumber; Type = [string].AsType();}
    )

    # Act
    Import-Module -Name $ModulePath -Verbose -Force
    Import-Module -Name $HelperModulePath -Verbose -Force

    # Assert
    Get-Module -Name 'Vine' | Should -Not -BeNullOrEmpty
    Get-Module -Name 'HelperModule' | Should -Not -BeNullOrEmpty
}

AfterAll {
    # Act
    Get-Module -Name 'HelperModule' | Remove-Module -Verbose
    Get-Module -Name 'Vine' | Remove-Module -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -BeNullOrEmpty
    Get-Module -Name 'Vine' | Should -BeNullOrEmpty
}

Describe -Name 'Vine Class' -Tag 'Red Green Tests' {
    Context -Name 'New-Vine Cmdlet Constructor' {
        Describe -Name 'Cmdlet Constructor' -Tag 'Cmdlet Constructor Tests' {
            It -Name 'Construct Vine and should not throw' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }

            It -Name 'Construct Vine which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32] which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with property FullName' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine

                # Act and Assert
                Test-HasProperty -Object $vine -Name 'FullName' | Should -BeTrue
            }

            It -Name 'Construct Vine with property Name' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine

                # Act and Assert
                Test-HasProperty -Object $vine -Name 'Name' | Should -BeTrue
            }

            It -Name "Construct Vine with property Name equals 'Vine'" -Tag 'Unit Test' {
                # Arrange,
                $vine = New-Vine

                # Assert
                $vine.Name | Should -Be 'Vine'
            }

            It -Name "Construct Vine with property FullName equals 'Vine'" -Tag 'Unit Test' {
                # Arrange,
                $vine = New-Vine

                # Assert
                $vine.FullName | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with property Type' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine

                # Assert
                Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
            }

            It -Name 'Construct Vine with property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Clear' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Dispose' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'Dispose' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Emplace' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
            }

            It -Name 'Construct Vine with method GetValue' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'GetValue' | Should -BeTrue
            }

            It -Name 'Construct Vine with method HasValue' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
            }

            It -Name 'Construct Vine with method OfType' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'OfType' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Swap' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                Test-HasMethod -Object $vine -Name 'Swap' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and vine should not be null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value and vine should have Property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name "Construct Vine with a value and vine should be of type 'Vine'" -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and vine should have property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine.Value should equal value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and a type' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer -Type ([type][Int32]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -Tag 'Unit Test' {
            # Arrange
                $vine = New-Vine -Value $TheAnswer, ([type][Int32])

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and a type and vine should have property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and a type and vine should have property Type' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and a type and vine.Value equals value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and a type and vine.Type equals type' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Act and Assert
                $vine.Type | Should -Be ([type][Int32])
            }
        }
    }

    Context -Name 'New-Object Constructor' {
        Describe -Name 'Vine Constructor' -Tag 'Constructor Tests' {
            It -Name 'Construct Vine and should not throw' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }

            It -Name 'Construct Vine which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32]) } | Should -Not -Throw
            }

            It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' 

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with property FullName' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine'

                # Act and Assert
                Test-HasProperty -Object $vine -Name 'FullName' | Should -BeTrue
            }

            It -Name 'Construct Vine with property Name' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine'

                # Act and Assert
                Test-HasProperty -Object $vine -Name 'Name' | Should -BeTrue
            }

            It -Name "Construct Vine with property Name equals 'Vine'" -Tag 'Unit Test' {
                # Arrange,
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.Name | Should -Be 'Vine'
            }

            It -Name "Construct Vine with property FullName equals 'Vine'" -Tag 'Unit Test' {
                # Arrange,
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.FullName | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with property Type' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
            }

            It -Name 'Construct Vine with property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Clear' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Dispose' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'Dispose' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Emplace' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
            }

            It -Name 'Construct Vine with method GetValue' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'GetValue' | Should -BeTrue
            }

            It -Name 'Construct Vine with method HasValue' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
            }

            It -Name 'Construct Vine with method OfType' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'OfType' | Should -BeTrue
            }

            It -Name 'Construct Vine with method Swap' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                Test-HasMethod -Object $vine -Name 'Swap' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and vine should not be null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value and vine should have Property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name "Construct Vine with a value and vine should be of type 'Vine'" -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and vine should have property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine.Value should equal value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and a type' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -Tag 'Unit Test' {
            # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32])

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and a type and vine.Value equals value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32])

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and a type and vine.Type equals type' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([type][Int32])

                # Act and Assert
                $vine.Type | Should -Be ([type][Int32])
            }
        }
    }

    Context -Name 'TypeAccelerator [Vine] Constructor' {
        It -Name 'Construct Vine and should not throw' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            { [Vine]::new() } | Should -Not -Throw
        }

        It -Name 'Construct Vine which is not null or empty' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine which is of Type 'Vine'" -Tag 'Unit Test' {
            # Arrange and Act
            $vine = [Vine]::new()

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine with Parameter Value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            { [Vine]::new($TheAnswer) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with Parameter Value which is not null or empty' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -Tag 'Unit Test' {
            # Arrange and Act
            $vine = [Vine]::new($TheAnswer)

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            { [Vine]::new($TheAnswer, ([type][Int32])) } | Should -Not -Throw
        }

        It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new()

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine with property FullName' -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new()

            # Act and Assert
            Test-HasProperty -Object $vine -Name 'FullName' | Should -BeTrue
        }

        It -Name 'Construct Vine with property Name' -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new()

            # Act and Assert
            Test-HasProperty -Object $vine -Name 'Name' | Should -BeTrue
        }

        It -Name "Construct Vine with property Name equals 'Vine'" -Tag 'Unit Test' {
            # Arrange,
            $vine = [Vine]::new()

            # Assert
            $vine.Name | Should -Be 'Vine'
        }

        It -Name "Construct Vine with property FullName equals 'Vine'" -Tag 'Unit Test' {
            # Arrange,
            $vine = [Vine]::new()

            # Assert
            $vine.FullName | Should -Be 'Vine'
        }

        It -Name 'Construct Vine with property Type' -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new()

            # Assert
            Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
        }

        It -Name 'Construct Vine with property Value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
        }

        It -Name 'Construct Vine with method Clear' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
        }

        It -Name 'Construct Vine with method Dispose' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'Dispose' | Should -BeTrue
        }

        It -Name 'Construct Vine with method Emplace' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
        }

        It -Name 'Construct Vine with method GetValue' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'GetValue' | Should -BeTrue
        }

        It -Name 'Construct Vine with method HasValue' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
        }

        It -Name 'Construct Vine with method OfType' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'OfType' | Should -BeTrue
        }

        It -Name 'Construct Vine with method Swap' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            Test-HasMethod -Object $vine -Name 'Swap' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            { [Vine]::($TheAnswer) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with a value and vine should not be null or empty' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name 'Construct Vine with a value and vine should have Property Value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            $vine.Value | Should -Be $TheAnswer
        }

        It -Name "Construct Vine with a value and vine should be of type 'Vine'" -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new($TheAnswer)

            # Act
            $type = $vine.GetType()

            # Assert
            $type.Name | Should -Be 'Vine'
        }

        It -Name 'Construct Vine with a value and vine should have property Value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and vine.Value should equal value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer)

            # Assert
            $vine.Value | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            { [Vine]::new($TheAnswer, ([type][Int32])) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer, ([type][Int32]))

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -Tag 'Unit Test' {
        # Arrange
            $vine = [Vine]::new($TheAnswer, ([type][Int32]))

            # Act
            $type = $vine.GetType()

            # Assert
            $type.Name | Should -Be 'Vine'
        }

        It -Name 'Construct Vine with a value and a type and vine.Value equals value' -Tag 'Unit Test' {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($TheAnswer, ([type][Int32]))

            # Assert
            $vine.Value | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type and vine.Type equals type' -Tag 'Unit Test' {
            # Arrange
            $vine = [Vine]::new($TheAnswer, ([type][Int32]))

            # Act and Assert
            $vine.Type | Should -Be ([type][Int32])
        }
    }

    Describe -Name 'Vine Method Clear' -Tag 'Method Clear Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32].AsType())

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and clear the value' -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act
            $vine.Clear()

            # Assert
            $vine.HasValue() | Should -BeFalse
        }

        It -Name 'Construct Vine with a value and a type, clear the value, and type should be unchanged' -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act
            $vine.Clear()

            # Assert
            $vine.TypeIs() | Should -Be [Int32]
        }
    }

    Describe -Name 'Vine Method Emplace' -Tag 'Method Emplace Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and emplace a new value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.Emplace($LuckyNumber) | Should -Be $LuckyNumber
        }
    }

    Describe -Name 'View Method Equals' -Tag 'Method Equals Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Equals' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and another vine with the same value and compare them for equality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            $right = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name 'Construct Vine with a value and another vine with a different value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            $right = New-Object -TypeName 'Vine' -ArgumentList $LuckyNumber, [Int32]
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine without a value and another vine without a value and compare them for equality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList [Int32]
            $right = New-Object -TypeName 'Vine' -ArgumentList [Int32]
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name 'Construct Vine with a value and another vine without a value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            $right = New-Object -TypeName 'Vine'
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine without a value and another vine with a value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine'
            $right = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    }

    Describe -Name 'Vine Method TypeIs' -Tag 'Method TypeIs Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'TypeIs' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and get the type' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.TypeIs() | Should -Be [Int32]
        }
    }

    Describe -Name 'Vine Method GetValue' -Tag 'Method GetValue Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'GetValue' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and get the value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type and get the value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type and get the value as a different type' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.GetValue([string].AsType()) | Should -Be ($TestData | Where-Object -Property Name -EQ 'StringAnswer' | Select-Object -ExpandProperty Value -First 1)
        }
    }

    Describe -Name 'Vine Method HasVelue' -Tag 'Method HasValue Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and has value should be true' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]

            # Act and Assert
            $vine.HasValue() | Should -BeTrue
        }
    
        It -Name 'Construct Vine without a value and has value should be false' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine'

            # Act and Assert
            $vine.HasValue() | Should -BeFalse
        }
    }
}
