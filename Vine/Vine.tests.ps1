#using module .\Vine.psd1
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
        @{Value = [Int32]::MinValue; Type = [type][Int32];},
        @{Value = 0; Type = [type][Int32];},
        @{Value = $TheAnswer; Type = [type][Int32];},
        @{Value = $LuckyNumber; Type = [type][Int32];},
        @{Value = $UnluckyNumber; Type = [type][Int32];},
        @{Value = [Int32]::MaxValue; Type = [type][Int32];},
        @{Value = [Int64]::MinValue; Type = [type][Int64];},
        @{Value = 0L; Type = [type][Int64];},
        @{Value = [Int64]$TheAnswer; Type = [type][Int64];},
        @{Value = [Int64]$LuckyNumber; Type = [type][Int64];},
        @{Value = [Int64]$UnluckyNumber; Type = [type][Int64];},
        @{Value = [Int64]::MaxValue; Type = [type][Int64];},
        @{Value = [decimal]::MinValue; Type = [decimal].AsType();},
        @{Value = [decimal]0; Type = [decimal].AsType();},
        @{Value = [decimal]$TheAnswer; Type = [decimal].AsType();},
        @{Value = [decimal]$LuckyNumber; Type = [decimal].AsType();},
        @{Value = [decimal]$UnluckyNumber; Type = [decimal].AsType();},
        @{Value = [decimal]::MaxValue; Type = [decimal].AsType();},
        @{Value = [double]::MinValue; Type = [double].AsType();},
        @{Value = [double]0.0; Type = [double].AsType();},
        @{Value = [double]::Epsilon; Type = [double].AsType();},
        @{Value = $TheAnswer * 1.0; Type = [double].AsType();},
        @{Value = $LuckyNumber * 1.0; Type = [double].AsType();},
        @{Value = $UnluckyNumber * 1.0; Type = [double].AsType();},
        @{Value = [double]::MaxValue; Type = [double].AsType();},
        @{Value = [Single]::MinValue; Type = [Single].AsType();},
        @{Value = [Single]0.0; Type = [Single].AsType();},
        @{Value = [Single]::Epsilon; Type = [Single].AsType();},
        @{Value = $TheAnswer * 1.0; Type = [Single].AsType();},
        @{Value = $LuckyNumber * 1.0; Type = [Single].AsType();},
        @{Value = $UnluckyNumber * 1.0; Type = [Single].AsType();},
        @{Value = [Single]::MaxValue; Type = [Single].AsType();},
        @{Value = -$TheAnswer; Type = [type][Int32];},
        @{Value = -$LuckyNumber; Type = [type][Int32];},
        @{Value = -$UnluckyNumber; Type = [type][Int32];},
        @{Value = [string]$TheAnswer; Type = [string].AsType();},
        @{Value = [string]$LuckyNumber; Type = [string].AsType();},
        @{Value = [string]$UnluckyNumber; Type = [string].AsType();}
    )

    $MethodList = @(
        'AsType',
        'BaseType',
        'Cast',
        'Clear',
        'Dispose',
        'Emplace',
        'Equals',
        'GetHashCode',
        'HasElementType',
        'HasValue',
        'IsArray',
        'IsClass',
        'IsInstanceOfType',
        'IsAssignableTo',
        'IsSubclassOf',
        'IsValueType',
        'NotEquals',
        'Swap',
        'ToString'
    )

    $PropertyList = @(
        'FullName',
        'Name',
        'Namespace',
        'Type',
        'Value'
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
            It -Name 'Construct Vine and should not throw' -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }

            It -Name 'Construct Vine which is not null or empty' -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine which is of Type 'Vine'" -Tag @('Unit', 'Test') {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value which is not null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange and Act
                $vine = New-Vine -Value $Value

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value, $Type } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32] which is not null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value -Type $Type

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine has properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Vine

                # Act
                Write-Verbose -Message "Testing property $_"

                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine has methods' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Vine

                # Act
                Write-Verbose -Message "Testing method $_"

                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine with a value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange and Act
                $vine = New-Vine -Value $Value

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value and vine should have properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Act
                Write-Verbose -Message "Testing property $_"

                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name "Construct Vine with a value and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Vine -Value $Value

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and vine should have property Value' -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine.Value should equal value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Construct Vine with a value and a type' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value -Type $Type } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value -Type $Type

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and a type and vine should have properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $TheAnswer -Type ([type][Int32])

                # Act
                Write-Verbose -Message "Testing property $_"

                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and a type and vine.Value equals value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value -Type $Type

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Construct Vine with a value and a type and vine.Type equals type' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act and Assert
                $vine.Type | Should -Be $Type
            }
        }
    }

    Context -Name 'New-Object Constructor' {
        Describe -Name 'Vine Constructor' -Tag 'Constructor Tests' {
            It -Name 'Construct Vine and should not throw' -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }

            It -Name 'Construct Vine which is not null or empty' -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine which is of Type 'Vine'" -Tag @('Unit', 'Test') {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value which is not null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange and Act
                $vine = New-Vine -Value $Value

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value, $Type } | Should -Not -Throw
            }

            It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Object -TypeName 'Vine' 

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine has properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Object -TypeName 'Vine'

                # Act
                Write-Verbose -Message "Testing property $_"

                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name "Construct Vine with property Name equals 'Vine'" -Tag @('Unit', 'Test') {
                # Arrange,
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.Name | Should -Be 'Vine'
            }

            It -Name "Construct Vine with property FullName equals 'Vine'" -Tag @('Unit', 'Test') {
                # Arrange,
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.FullName | Should -Be 'Vine'
            }

            It -Name 'Construct Vine has methods' -ForEach $MethodList -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Act
                Write-Verbose -Message "Testing method $_"

                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine with a value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value and vine should have properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Act
                Write-Verbose -Message "Testing property $_"

                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name "Construct Vine with a value and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and vine.Value should equal value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Construct Vine with a value and a type' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value, $Type } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and a type and vine.Value equals value' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Construct Vine with a value and a type and vine.Type equals type' -ForEach $TestData -Tag @('Unit', 'Test') {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Act and Assert
                $vine.Type | Should -Be $Type
            }
        }
    }

    Context -Name 'TypeAccelerator [Vine] Constructor' {
        It -Name 'Construct Vine and should not throw' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { [Vine]::new() } | Should -Not -Throw
        }

        It -Name 'Construct Vine which is not null or empty' -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine which is of Type 'Vine'" -Tag @('Unit', 'Test') {
            # Arrange and Act
            $vine = [Vine]::new()

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine with Parameter Value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { [Vine]::new($Value) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with Parameter Value which is not null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine with Parameter Value which is of Type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange and Act
            $vine = [Vine]::new($Value)

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { [Vine]::new($Value, $Type) } | Should -Not -Throw
        }

        It -Name "Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type 'Vine'" -Tag @('Unit', 'Test') {
            # Arrange
            $vine = [Vine]::new()

            # Assert
            $vine.GetType() | Should -BeOfType 'Vine'
        }

        It -Name 'Construct Vine has properties' -ForEach $PropertyList -Tag @('Unit', 'Test') {
            # Arrange
            $vine = [Vine]::new()

            # Act
            Write-Verbose -Message "Testing property $_"

            # Assert
            $_ | Test-HasProperty -Object $vine | Should -BeTrue
        }

        It -Name "Construct Vine with property Name equals 'Vine'" -Tag @('Unit', 'Test') {
            # Arrange,
            $vine = [Vine]::new()

            # Assert
            $vine.Name | Should -Be 'Vine'
        }

        It -Name "Construct Vine with property FullName equals 'Vine'" -Tag @('Unit', 'Test') {
            # Arrange,
            $vine = [Vine]::new()

            # Assert
            $vine.FullName | Should -Be 'Vine'
        }

        It -Name 'Construct Vine has methods' -ForEach $MethodList -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new()

            # Act
            Write-Verbose -Message "Testing method $_"

            # Assert
            $_ | Test-HasMethod -Object $vine | Should -BeTrue
        }

        It -Name 'Construct Vine with a value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { [Vine]::($Value) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with a value and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name 'Construct Vine with a value and vine should have Property Value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and vine should have Property Value with value TheAnswer' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            $vine.Value | Should -Be $Value
        }

        It -Name "Construct Vine with a value and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = [Vine]::new($Value)

            # Act
            $type = $vine.GetType()

            # Assert
            $type.Name | Should -Be 'Vine'
        }

        It -Name 'Construct Vine with a value and vine should have property Value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and vine.Value should equal value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value)

            # Assert
            $vine.Value | Should -Be $Value
        }

        It -Name 'Construct Vine with a value and a type' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            { [Vine]::new($Value, $Type) } | Should -Not -Throw
        }

        It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value, $Type)

            # Assert
            $vine | Should -Not -BeNullOrEmpty
        }

        It -Name "Construct Vine with a value and a type and vine should be of type 'Vine'" -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = [Vine]::new($Value, $Type)

            # Act
            $type = $vine.GetType()

            # Assert
            $type.Name | Should -Be 'Vine'
        }

        It -Name 'Construct Vine with a value and a type and vine.Value equals value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange, Act, and Assert
            $vine = [Vine]::new($Value, $Type)

            # Assert
            $vine.Value | Should -Be $Value
        }

        It -Name 'Construct Vine with a value and a type and vine.Type equals type' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = [Vine]::new($Value, $Type)

            # Act and Assert
            $vine.Type | Should -Be $Type
        }
    }

    Describe -Name 'Vine Method AsType' -ForEach $TestData -Tag 'Method AsType Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'AsType' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and AsType should return the type' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine     = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            $expected = $vine.Type
            
            # Act
            $actual = $vine.AsType()

            # Act and Assert
            $expected | Should -Be $actual
        }
    }

    Describe -Name 'Vine static Method BaseType' -ForEach $TestData -Tag 'Method BaseType Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'BaseType' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and BaseType should return the type' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine     = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            $expected = ($vine.Type).BaseType
            
            # Act
            $actual = [Vine]::BaseType($vine)

            # Act and Assert
            $expected | Should -Be $actual
        }
    }

    Describe -Name 'Vine Method Cast' -ForEach $TestData -Tag 'Method Cast Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Cast' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and Cast should return the value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine     = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            $expected = [string]$vine.Value
            
            # Act
            $actual = $vine.Cast([string].AsType())

            # Act and Assert
            $expected | Should -Be $actual
        }
    }

    Describe -Name 'Vine Method Clear' -ForEach $TestData -Tag 'Method Clear Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and clear the value' -ForEach $TestData -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act
            $vine.Clear()

            # Assert
            $vine.HasValue() | Should -BeFalse
        }

        It -Name 'Construct Vine with a value and a type, clear the value, and type should be unchanged' -ForEach $TestData -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act
            $vine.Clear()

            # Assert
            $vine.TypeIs() | Should -Be $Type
        }
    }

    Describe -Name 'Vine Method Dispose' -ForEach $TestData -Tag 'Method Dispose Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Dispose' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and dispose the vine' -ForEach $TestData -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act
            $vine.Dispose()

            # Assert
            $vine.HasValue() | Should -BeFalse
        }

        It -Name 'Construct Vine with a value and a type, dispose the vine, and type should be unchanged' -ForEach $TestData -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act
            $vine.Dispose()

            # Assert
            $vine.Type | Should -Be $Type
        }
    }

    Describe -Name 'Vine Method Emplace' -ForEach $TestData -Tag 'Method Emplace Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and emplace a new value' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            $vine.Emplace($LuckyNumber) | Should -Be $Value
        }
    }

    Describe -Name 'View Method Equals' -ForEach $TestData -Tag 'Method Equals Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Equals' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and another vine with the same value and compare them for equality' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            $right = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name 'Construct Vine with a value and another vine with a different value and compare them for inequality' -Tag @('Unit', 'Test') {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, [Int32]
            $right = New-Object -TypeName 'Vine' -ArgumentList $LuckyNumber, [Int32]
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine with a value and another vine without a value and compare them for inequality' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            $right = New-Object -TypeName 'Vine'
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine without a value and another vine with a value and compare them for inequality' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $left  = New-Object -TypeName 'Vine'
            $right = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    }

    Describe -Name 'Vine Method GetHashCode' -ForEach $TestData -Tag 'Method GetHashCode Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'GetHashCode' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and get the hash code' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            $vine.GetHashCode() | Should -Be $TheAnswer.GetHashCode()
        }
    }

    Describe -Name 'Vine Method HasValue' -ForEach $TestData -Tag 'Method HasValue Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
        }

        It -Name 'Construct Vine with a value and a type and has value should be true' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            $vine.HasValue() | Should -BeTrue
        }
    
        It -Name 'Construct Vine without a value and has value should be false' -Tag @('Unit', 'Test') {
            # Arrange
            $vine = New-Object -TypeName 'Vine'

            # Act and Assert
            $vine.HasValue() | Should -BeFalse
        }
    }

    Describe -Name 'Vine static Method HasElementType' -ForEach $TestData -Tag 'Method HasElementType Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'HasElementType' | Should -BeTrue
        }
    }

    Describe -Name 'View Method HasValue' -ForEach $TestData -Tag 'Method HasValue Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsArray' -ForEach $TestData -Tag 'Method IsArray Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsArray' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsClass' -ForEach $TestData -Tag 'Method IsClass Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsClass' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsInstanceOfType' -ForEach $TestData -Tag 'Method IsInstanceOfType Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsInstanceOfType' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsAssignableTo' -ForEach $TestData -Tag 'Method IsAssignableTo Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsAssignableTo' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsSubclassOf' -ForEach $TestData -Tag 'Method IsSubclassOf Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsSubclassOf' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method IsValueType' -ForEach $TestData -Tag 'Method IsValueType Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'IsValueType' | Should -BeTrue
        }
    }
    
    Describe -Name 'Vine Method NotEquals' -ForEach $TestData -Tag 'Method NotEquals Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'NotEquals' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method NotEquals' -ForEach $TestData -Tag 'Method NotEquals Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'NotEquals' | Should -BeTrue
        }
    }

    Describe -Name 'Vine static Method Swap' -ForEach $TestData -Tag 'Method Swap Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'Swap' | Should -BeTrue
        }
    }

    Describe -Name 'Vine Method ToString' -ForEach $TestData -Tag 'Method ToString Tests' {
        Context -Name 'Exists' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

            # Act and Assert
            Test-HasMethod -Object $vine -Name 'ToString' | Should -BeTrue
        }
    }
}
