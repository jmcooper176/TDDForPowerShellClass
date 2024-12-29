using module .\Vine.psd1

<#
    Vine Pester Tests Based on the Pester Framework and STL Any Class

    https://learn.microsoft.com/en-us/cpp/standard-library/any-class?view=msvc-170#members
#>

BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\Vine.psd1' -Resolve
    $HelperModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\HelperModule\HelperModule.psd1' -Resolve
    $TypeAcceleratorPath = Join-Path -Path $PSScriptRoot -ChildPath '.\TypeAccelerator.psd1' -Resolve

    Set-Variable -Name EvenPrime -Option Constant -Value 2
    Set-Variable -Name SecondPrime -Option Constant -Value 3
    Set-Variable -Name ThirdPrime -Option Constant -Value 5
    Set-Variable -Name LuckyNumber -Option Constant -Value 7
    Set-Variable -Name FifthPrime -Option Constant -Value 11
    Set-Variable -Name UnluckyNumber -Option Constant -Value 13
    Set-Variable -Name SeventhPrime -Option Constant -Value 17
    Set-Variable -Name EighthPrime -Option Constant -Value 19
    Set-Variable -Name NinthPrime -Option Constant -Value 23
    Set-Variable -Name TenthPrime -Option Constant -Value 29
    Set-Variable -Name EleventhPrime -Option Constant -Value 31
    Set-Variable -Name TwelfthPrime -Option Constant -Value 37
    Set-Variable -Name ThirteenthPrime -Option Constant -Value 41
    Set-Variable -Name TheAnswer -Option Constant -Value 42
    Set-Variable -Name FourteenthPrime -Option Constant -Value 43
    Set-Variable -Name FifteenthPrime -Option Constant -Value 47
    Set-Variable -Name SixteenthPrime -Option Constant -Value 53
    Set-Variable -Name SeventeenthPrime -Option Constant -Value 59
    Set-Variable -Name EighteenthPrime -Option Constant -Value 61
    Set-Variable -Name NineteenthPrime -Option Constant -Value 67
    Set-Variable -Name TwentiethPrime -Option Constant -Value 71
    Set-Variable -Name TwentyFirstPrime -Option Constant -Value 73
    Set-Variable -Name TwentySecondPrime -Option Constant -Value 79
    Set-Variable -Name TwentyThirdPrime -Option Constant -Value 83
    Set-Variable -Name TwentyFourthPrime -Option Constant -Value 89
    Set-Variable -Name TwentyFifthPrime -Option Constant -Value 97

    $TestData = @(
        @{Value = [sbyte]::MinValue; Type = [sbyte].AsType(); },
        @{Value = [sbyte]::MaxValue; Type = [sbyte].AsType(); },
        @{Value = [byte]::MinValue; Type = [type].AsType(); },
        @{Value = [byte]::MaxValue; Type = [byte].AsType(); },
        @{Value = [Int16]::MinValue; Type = [Int16].AsType(); },
        @{Value = [Int16]::MaxValue; Type = [Int16].AsType(); },
        @{Value = [Int32]::MinValue; Type = [Int32].AsType(); },
        @{Value = 0; Type = [Int32].AsType(); },
        @{Value = $TheAnswer; Type = [Int32].AsType(); },
        @{Value = $LuckyNumber; Type = [Int32].AsType(); },
        @{Value = $UnluckyNumber; Type = [Int32].AsType(); },
        @{Value = [Int32]::MaxValue; Type = [Int32].AsType(); },
        @{Value = [Int64]::MinValue; Type = [Int64].AsType(); },
        @{Value = 0L; Type = [Int64].AsType(); },
        @{Value = [Int64]$TheAnswer; Type = [Int64].AsType(); },
        @{Value = [Int64]$LuckyNumber; Type = [Int64].AsType(); },
        @{Value = [Int64]$UnluckyNumber; Type = [Int64].AsType(); },
        @{Value = [Int64]::MaxValue; Type = [Int64].AsType(); },
        @{Value = [decimal]::MinValue; Type = [decimal].AsType(); },
        @{Value = [decimal]0; Type = [decimal].AsType(); },
        @{Value = [decimal]$TheAnswer; Type = [decimal].AsType(); },
        @{Value = [decimal]$LuckyNumber; Type = [decimal].AsType(); },
        @{Value = [decimal]$UnluckyNumber; Type = [decimal].AsType(); },
        @{Value = [decimal]::MaxValue; Type = [decimal].AsType(); },
        @{Value = [double]::MinValue; Type = [double].AsType(); },
        @{Value = [double]0.0; Type = [double].AsType(); },
        @{Value = [double]::Epsilon; Type = [double].AsType(); },
        @{Value = $TheAnswer * 1.0; Type = [double].AsType(); },
        @{Value = $LuckyNumber * 1.0; Type = [double].AsType(); },
        @{Value = $UnluckyNumber * 1.0; Type = [double].AsType(); },
        @{Value = [double]::MaxValue; Type = [double].AsType(); },
        @{Value = [Single]::MinValue; Type = [Single].AsType(); },
        @{Value = [Single]0.0; Type = [Single].AsType(); },
        @{Value = [Single]::Epsilon; Type = [Single].AsType(); },
        @{Value = $TheAnswer * 1.0; Type = [Single].AsType(); },
        @{Value = $LuckyNumber * 1.0; Type = [Single].AsType(); },
        @{Value = $UnluckyNumber * 1.0; Type = [Single].AsType(); },
        @{Value = [Single]::MaxValue; Type = [Single].AsType(); },
        @{Value = - $TheAnswer; Type = [Int32].AsType(); },
        @{Value = - $LuckyNumber; Type = [Int32].AsType(); },
        @{Value = - $UnluckyNumber; Type = [Int32].AsType(); },
        @{Value = [string]$TheAnswer; Type = [string].AsType(); },
        @{Value = [string]$LuckyNumber; Type = [string].AsType(); },
        @{Value = [string]$UnluckyNumber; Type = [string].AsType(); }
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
        'ClassType',
        'FullName',
        'Name',
        'Namespace',
        'Type',
        'Value'
    )

    # Act
    Import-Module -Name $HelperModulePath -Verbose -Force

    # Assert
    Get-Module -Name 'HelperModule' | Should -Not -BeNull
}

AfterAll {
    # Act
    Get-Module -Name 'HelperModule' | Remove-Module -Verbose

    # Assert
    Get-Module -Name 'HelperModule' | Should -BeNull
}

<#
    Module
#>
Describe -Name 'Vine' -Tag 'Module', 'Unit', 'Test', 'Red', 'Green' {
    Context -Name 'Module Manifest' {
        It 'should have a RootModule of Vine.psm1' {
            # Arrange and Act
            $RootModule = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'RootModule'

            # Assert
            $RootModule | Should -Be 'Vine.psm1'
        }

        It 'should have a ModuleVersion of at least 0.0.1' {
            # Arrange and Act
            $ModuleVersion = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'Version'
        
            # Assert
            $ModuleVersion | Should -BeGreaterOrEqual '0.0.1'
        }

        It 'should have a GUID of d1c6730d-3d94-4885-91bd-1a8df1c59521' {
            # Arrange and Act
            $Guid = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'GUID'

            # Assert
            $Guid | Should -Be 'd1c6730d-3d94-4885-91bd-1a8df1c59521'
        }

        It 'should have an Author of John Merryweather Cooper' {
            # Arrange and Act
            $Author = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'Author'
        
            # Assert
            $Author | Should -Be 'John Merryweather Cooper'
        }

        It 'should have a CompanyName of Ram Tuned Mega Code' {
            # Arrange and Act
            $CompanyName = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'CompanyName'
        
            # Assert
            $CompanyName | Should -Be 'Ram Tuned Mega Code'
        }

        It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
            # Arrange and Act
            $Copyright = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'Copyright'
        
            # Assert
            $Copyright | Should -Be 'Copyright © 2024, John Merryweather Cooper.  All Rights Reserved.'
        }

        It 'should have a Description of Base class example for Test Driven Design for PowerShell Classes.' {
            # Arrange and Act
            $Description = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'Description'

            # Assert
            $Description | Should -Be 'Base class example for Test Driven Design for PowerShell Classes.'
        }

        It 'should have a PowerShellVersion of 5.1' {
            # Arrange and Act
            $PowerShellVersion = Test-ModuleManifest -Path '.\Vine.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'

            # Assert
            $PowerShellVersion | Should -Be '5.1'
        }
    }

    Context -Name 'Constructors' {
        Context -Name 'New-Vine Cmdlet Default Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }
    
            It -Name 'Should not throw' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }
        }

        Context -Name 'New-Object TypeName Vine Default Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
    
                # Assert
                Get-Module -Name 'Vine' | Should -BeNull
            }
    
            It -Name 'Should not throw' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' } | Should -Not -Throw
            }
    
            It -Name 'Instance is not null or empty' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine'
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine'
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }
        }

        Context -Name 'TypeAccelerator [Vine] Default Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }
    
            It -Name 'TypeAccelerator Vine should not throw' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { [Vine]::new() } | Should -Not -Throw
            }
    
            It -Name 'TypeAccelerator Vine instance is not null or empty' -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = [Vine]::new()
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'TypeAccelerator Vine has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new()
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }

            It -Name 'TypeAccelerator Vine has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = [Vine]::new()
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }
    
            It -Name "Static property ClassType is of Type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }
        }

        Context -Name 'New-Vine Cmdlet Value Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }
    
            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $Value

                # Act and Assert
                $vine.Value | Should -Be $Value
            }
        }

        Context -Name 'New-Object TypeName Vine Value Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }
    
            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Value' -ArgumentList $Value
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -TypeName $TheAnswer
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value

                # Act and Assert
                $vine.Value | Should -Be $Value
            }
        }

        Context -Name 'TypeAccelerator [Vine] Value Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }
    
            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { [Vine]::new($Value) } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = [Vine]::new($Value)
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($TheAnswer)
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($TheAnswer)
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($Value)

                # Act and Assert
                $vine.Value | Should -Be $Value
            }
        }

        Context -Name 'New-Vine Cmdlet Value and Type Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }

            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value -Type $Type } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value -Type $Type
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act and Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Type property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act and Assert
                $vine.Type | Should -Be $Type
            }
        }

        Context -Name 'New-Object TypeName Vine Value and Type Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }

            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $Value, $Type } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Act and Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Type property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $Value, $Type

                # Act and Assert
                $vine.Type | Should -Be $Type
            }
        }

        Context -Name 'TypeAccelerator [Vine] Value and Type Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }

            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $Value -Type $Type } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = New-Vine -Value $Value -Type $Type
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $TheAnswer -Type ([int].AsType())
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act and Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Type property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = New-Vine -Value $Value -Type $Type

                # Act and Assert
                $vine.Type | Should -Be $Type
            }
        }

        Context -Name 'New-Object TypeName Vine Value and Type Constructor' {
            BeforeEach {
                # Arrange
                Import-Module -Name $ModulePath -Force
            }
    
            AfterEach {
                # Act
                Get-Module -Name 'Vine' | Remove-Module -Force
            }

            It -Name 'Should not throw' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                { [Vine]::new($Value, $Type) } | Should -Not -Throw
            }
    
            It -Name 'Instance should not be null or empty' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                $vine = [Vine]::new($Value, $Type)
    
                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
    
            It -Name 'Instance has all properties' -ForEach $PropertyList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                # Act
                Write-Verbose -Message "Testing property $_"
    
                # Assert
                $_ | Test-HasProperty -Object $vine | Should -BeTrue
            }
    
            It -Name 'Instance has all methods' -ForEach $MethodList -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($Value, $Type)
    
                # Act
                Write-Verbose -Message "Testing method $_"
    
                # Assert
                $_ | Test-HasMethod -Object $vine | Should -BeTrue
            }

            It -Name "Static property ClassType equals type 'Vine'" -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::ClassType | Should -BeOfType ('Vine' -as [type])
            }
    
            It -Name "Static property Name equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::Name | Should -Be 'Vine'
            }
    
            It -Name "Static property FullName equals 'Vine'" -Tag 'Unit', 'Test' {
                # Arrange, Act, and Assert
                [Vine]::FullName | Should -Be 'Vine'
            }

            It -Name 'Value property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($Value, $Type)

                # Act and Assert
                $vine.Value | Should -Be $Value
            }

            It -Name 'Type property has expected value' -ForEach $TestData -Tag 'Unit', 'Test' {
                # Arrange
                $vine = [Vine]::new($Value, $Type)

                # Act and Assert
                $vine.Type | Should -Be $Type
            
            }
        }

        Context -Name 'Methods' {
            Context -Name 'AsType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'AsType' | Should -BeTrue
                }

                It -Name 'Value and Type with AsType called should return Type' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
        
                    # Act and Assert
                    $Type | Should -BeOfType $vine.AsType()
                }
            }

            Context -Name 'BaseType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'BaseType' | Should -BeTrue
                }

                It -Name 'Value and Type with BaseType called should return Type' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
                    $expected = ($vine.Type).BaseType
                    
                    # Act
                    $actual = [Vine]::BaseType($vine)
        
                    # Act and Assert
                    $expected | Should -Be $actual
                }
            }

            Context -Name 'Cast' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Cast' | Should -BeTrue
                }

                It -Name 'Value and Type with Cast called should return cast Value' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
                    $expected = [string]$vine.Value
                    
                    # Act
                    $actual = $vine.Cast([string].AsType())
        
                    # Act and Assert
                    $expected | Should -Be $actual
                }
            }

            Context -Name 'Clear' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Clear' | Should -BeTrue
                }

                It -Name 'Value and Type with Clear called Type should be Type' -ForEach $TestData -Tag 'Integration Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
        
                    # Act
                    $vine.Clear()
        
                    # Assert
                    $vine.TypeIs() | Should -Be $Type
                }
            }

            Context -Name 'Dispose' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Dispose' | Should -BeTrue
                }

                It -Name 'Value and Type With Dispose called HasValue() should be false' -ForEach $TestData -Tag 'Integration Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
        
                    # Act
                    $vine.Dispose()
        
                    # Assert
                    $vine.HasValue() | Should -BeFalse
                }

                It -Name 'Value and Type with Dispose called Type should be Type' -ForEach $TestData -Tag 'Integration Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
        
                    # Act
                    $vine.Dispose()
        
                    # Assert
                    $vine.Type | Should -Be $Type
                }
            }

            Context -Name 'Emplace' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Emplace' | Should -BeTrue
                }

                It -Name 'Value and Type with Emplace called with Value equals Value' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, $Type)
        
                    # Act
                    $vine.Emplace($Value)
        
                    # Assert
                    $vine.Value | Should -Be $Value
                }
            }
        
            Context -Name 'Equals' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Equals' | Should -BeTrue
                }

                It -Name 'Left Value and same Right value are Equal' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $left = [Vine]::new($Value, $Type)
                    $right = [Vine]::new($Value, $Type)
                    
                    # Act and Assert
                    $left.Equals($right) | Should -BeTrue
                }

                It -Name 'Left Value and Right Default are Not Equal' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $left = [Vine]::new($Value, $Type)
                    $right = [Vine]::new()
                    
                    # Act and Assert
                    $left.Equals($right) | Should -BeFalse
                }
            
                It -Name 'Left Vine with Default Value and Right Value are Not Equal' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $left = [Vine]::new()
                    $right = [Vine]::new($Value, $Type)
                    
                    # Act and Assert
                    $left.Equals($right) | Should -BeFalse
                }
            }

            Context -Name 'GetHashCode' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'GetHashCode' | Should -BeTrue
                }

                It -Name 'Left Value and Right Value Have Different Hash Codes' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $left = [Vine]::new($Value, $Type)
                    $right = [Vine]::new(-$Value, $Type)
        
                    # Act and Assert
                    $left.GetHashCode() | Should -Not -Be $right.GetHashCode()
                }
            }

            Context -Name 'HasElementType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'HasElementType' | Should -BeTrue
                }
            }

            Context -Name 'HasValue' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'HasValue' | Should -BeTrue
                }

                It -Name 'Value and Type with HasValue called is True' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($Value, $Type)
        
                    # Act and Assert
                    $vine.HasValue() | Should -BeTrue
                }
            }

            Context -Name 'IsArray' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsArray' | Should -BeTrue
                }
            }

            Context -Name 'IsClass' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsClass' | Should -BeTrue
                }
            }

            Context -Name 'IsInstanceOfType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsInstanceOfType' | Should -BeTrue
                }
            }

            Context -Name 'IsAssignableTo' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsAssignableTo' | Should -BeTrue
                }
            }

            Context -Name 'IsSubclassOf' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsSubclassOf' | Should -BeTrue
                }
            }

            Context -Name 'IsValueType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'IsValueType' | Should -BeTrue
                }
            }

            Context -Name 'NotEquals' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'NotEquals' | Should -BeTrue
                }

                It -Name 'Left Value and Negative Right value are Not Equal' -ForEach $TestData -Tag 'Unit', 'Test' {
                    # Arrange
                    $left = [Vine]::new($Value, $Type)
                    $right = [Vine]::new(-$Value, $Type)
                    
                    # Act and Assert
                    $left.NotEquals($right) | Should -BeTrue
                }
            }

            Context -Name 'Swap' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'Swap' | Should -BeTrue
                }
            }

            Context -Name 'ToString' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasMethod -Object $vine -Name 'ToString' | Should -BeTrue
                }
            }
        }

        Context -Name 'Properties' {
            Context -Name 'ClassType' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'ClassType' | Should -BeTrue
                }
            }

            Context -Name 'FullName' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'FullName' | Should -BeTrue
                }
            }

            Context -Name 'Name' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'Name' | Should -BeTrue
                }
            }

            Context -Name 'Type' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
                }
            }

            Context -Name 'Namespace' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'Namespace' | Should -BeTrue
                }
            }

            Context -Name 'Type' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
                }
            }

            Context -Name 'Value' {
                It -Name 'Exists' -Tag 'Unit', 'Test' {
                    # Arrange
                    $vine = [Vine]::new($TheAnswer, ([int].AsType()))
    
                    # Act and Assert
                    Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
                }
            }
        }
    }
}
