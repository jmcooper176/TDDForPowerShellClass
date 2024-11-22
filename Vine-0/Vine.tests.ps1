using module ..\Vine\Vine.psd1

<#
    Vine Pester Tests Based on the Pester Framework and STL Any Class

    https://learn.microsoft.com/en-us/cpp/standard-library/any-class?view=msvc-170#members
#>

BeforeAll {
    # Arrange
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\Vine\Vine.psd1' -Resolve

    Set-Variable -Name TheAnswer -Option Constant -Value 42
    Set-Variable -Name LuckyNumber -Option Constant -Value 7
    Set-Variable -Name UnluckyNumber -Option Constant -Value 13

    $TestData = @(
        [PSCustomObject]@{Name = 'NormalAnswer'; Value = $TheAnswer; Type = [Int32];},
        [PSCustomObject]@{Name = 'NormalLucky'; Value = $LuckyNumber; Type = [Int32];},
        [PSCustomObject]@{Name = 'NormalUnlucky'; Value = $UnluckyNumber; Type = [Int32];},
        [PSCustomObject]@{Name = 'LongAnswer'; Value = [Int64]$TheAnswer; Type = [Int64];},
        [PSCustomObject]@{Name = 'LongLucky'; Value = [Int64]$LuckyNumber; Type = [Int64];},
        [PSCustomObject]@{Name = 'LongUnlucky'; Value = [Int64]$UnluckyNumber; Type = [Int64];},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [decimal];},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [decimal];},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [decimal];},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [Single];},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [Single];},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [Single];},
        [PSCustomObject]@{Name = 'NegativeAnswer'; Value = -$TheAnswer; Type = [Int32];},
        [PSCustomObject]@{Name = 'NegativeLucky'; Value = -$LuckyNumber; Type = [Int32];},
        [PSCustomObject]@{Name = 'NegativeUnlucky'; Value = -$UnluckyNumber; Type = [Int32];},
        [PSCustomObject]@{Name = 'StringAnswer'; Value = [string]$TheAnswer; Type = [string];},
        [PSCustomObject]@{Name = 'StringLucky'; Value = [string]$LuckyNumber; Type = [string];},
        [PSCustomObject]@{Name = 'StringUnlucky'; Value = [string]$UnluckyNumber; Type = [string];}
    )

    # Act
    Import-Module -Name $ModulePath -Verbose

    # Assert
    Get-Module -Name 'Vine' | Should -Not -BeNullOrEmpty
}

AfterAll {
    # Act
    Get-Module -Name 'Vine' | Remove-Module -Verbose

    # Assert
    Get-Module -Name 'Vine' | Should -BeNullOrEmpty
}

Describe -Name 'Vine Class' -Tag 'Red Green Tests' {
    Context -Name 'Cmdlet Constructor' {
        Describe -Name 'Cmdlet Constructor' -Tag 'Cmdlet Constructor Tests' {
            It -Name 'Construct Vine with no parameters and not throw' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine } | Should -Not -Throw
            }

            It -Name 'Construct Vine with no parameters which is not null or empty' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with no parameters which is of Type [Vine]' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine

                # Assert
                $vine | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with a value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value which is not null or empty' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value which is of Type [Vine]' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine -Value $TheAnswer

                # Assert
                $vine | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with a value and a type' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Vine -Value $TheAnswer -Type ([Int32] -as [Type]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type which is not null or empty' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Vine -Value $TheAnswer -Type ([Int32] -as [Type])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }
        }
    }

    Context -Name 'New-Object Constructor' {
        Describe -Name 'Vine Constructor' -Tag 'Constructor Tests' {
            It -Name 'Construct Vine and should not throw' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' } | Should -Not -Throw
            }

            It -Name 'Construct Vine which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine which is of Type [Vine]' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with Parameter Value which is of Type [Vine]' -Tag 'Unit Test' {
                # Arrange and Act
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer

                # Assert
                $vine.GetType() | Should -BeOfType 'Vine'
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32]' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32] which is not null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with Parameter Value and Parameter Type [Int32] which is of Type [Vine]' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

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

            It -Name 'Construct Vine with property Name equals [Vine]' -Tag 'Unit Test' {
                # Arrange,
                $vine = New-Object -TypeName 'Vine'

                # Assert
                $vine.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with property FullName equals 'Vine'' -Tag 'Unit Test' {
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
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and vine should be of type [Vine]' -Tag 'Unit Test' {
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
                { New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type]) } | Should -Not -Throw
            }

            It -Name 'Construct Vine with a value and a type and vine should not be null or empty' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Assert
                $vine | Should -Not -BeNullOrEmpty
            }

            It -Name 'Construct Vine with a value and a type and vine should be of type [Vine]' -Tag 'Unit Test' {
            # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Act
                $type = $vine.GetType()

                # Assert
                $type.Name | Should -Be 'Vine'
            }

            It -Name 'Construct Vine with a value and a type and vine should have property Value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Assert
                Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and a type and vine should have property Type' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Assert
                Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
            }

            It -Name 'Construct Vine with a value and a type and vine.Value equals value' -Tag 'Unit Test' {
                # Arrange, Act, and Assert
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Assert
                $vine.Value | Should -Be $TheAnswer
            }

            It -Name 'Construct Vine with a value and a type and vine.Type equals type' -Tag 'Unit Test' {
                # Arrange
                $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

                # Act and Assert
                $vine.Type | Should -Be ([Int32] -as [Type])
            }
        }
    }

    Context -Name 'TypeAccelerator [Vine] Constructor' {

    }

    Describe -Name 'Vine Method Clear' -Tag 'Method Clear Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and a type and clear the value' -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act
            $vine.Clear()

            # Assert
            $vine.HasValue() | Should -BeFalse
        }

        It -Name 'Construct Vine with a value and a type, clear the value, and type should be unchanged' -Tag 'Integration Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act
            $vine.Clear()

            # Assert
            $vine.TypeIs() | Should -Be ([Int32] -as [Type])
        }
    }

    Describe -Name 'Vine Method Emplace' -Tag 'Method Emplace Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and a type and emplace a new value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act and Assert
            $vine.Emplace($LuckyNumber) | Should -Be $LuckyNumber
        }
    }

    Describe -Name 'View Method Equals' -Tag 'Method Equals Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and another vine with the same value and compare them for equality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])
            $right = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name 'Construct Vine with a value and another vine with a different value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])
            $right = New-Object -TypeName 'Vine' -ArgumentList $LuckyNumber, ([Int32] -as [Type])
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine without a value and another vine without a value and compare them for equality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList ([Int32] -as [Type])
            $right = New-Object -TypeName 'Vine' -ArgumentList ([Int32] -as [Type])
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name 'Construct Vine with a value and another vine without a value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])
            $right = New-Object -TypeName 'Vine'
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name 'Construct Vine without a value and another vine with a value and compare them for inequality' -Tag 'Unit Test' {
            # Arrange
            $left  = New-Object -TypeName 'Vine'
            $right = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    }

    Describe -Name 'Vine Method TypeIs' -Tag 'Method TypeIs Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and a type and get the type' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act and Assert
            $vine.TypeIs() | Should -Be ([Int32] -as [Type])
        }
    }

    Describe -Name 'Vine Method GetValue' -Tag 'Method GetValue Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and a type and get the value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type and get the value' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name 'Construct Vine with a value and a type and get the value as a different type' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

            # Act and Assert
            $vine.GetValue([string]) | Should -Be ($TestData | Where-Object -Property Name -EQ 'StringAnswer' | Select-Object -ExpandProperty Value -First 1)
        }
    }

    Describe -Name 'Vine Method HasVelue' -Tag 'Method HasValue Tests' {
        Context -Name 'Exists' {

        }

        It -Name 'Construct Vine with a value and a type and has value should be true' -Tag 'Unit Test' {
            # Arrange
            $vine = New-Object -TypeName 'Vine' -ArgumentList $TheAnswer, ([Int32] -as [Type])

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

<#
    Test-HasMethod
#>
function Test-HasMethod {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory)]
        [PSObject]
        $Object,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [switch]
        $Strict
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if ($null -eq $Object) {
            $message = "$($CmdletName) : ArgumentNullException : The value of the Object parameter cannot be null."

            if ($Strict.IsPresent) {
                $ex = [System.ArgumentNullException]::new('Object', $message)

                Write-Error -Message $message -Exception $ex -Category InvalidArgument -TargetObject $Object -ErrorAction Continue

                throw $ex
            } else {
                Write-Warning -Message $message
                $false | Write-Output
            }
        }
    }

    PROCESS {
        $Object.PSObject.Methods | Where-Object -Property Name -EQ $Name | Write-Output
    }

    <#
        .SYNOPSIS
        Tests an object fo the presence of a method.

        .DESCRIPTION
        The `Test-HasProperty` function tests an object for the presence of a method.

        .PARAMETER Object
        Specifies the PowerShell object under test.

        .PARAMETER Name
        Specifies the name of the method to test for.

        .PARAMETER Strict
        Indicates that the function should throw an exception if the Object parameter is null.

        .INPUTS
        [string]  `Test-HasMethod` accepts a string value for the Name parameter from the PowerShell pipeline.

        .OUTPUTS
        [bool]  `Test-HasProperty` returns a boolean value indicating the presence or absence of the method to the PowerShell pipeline.

        .EXAMPLE
        PS> $Object = [PSCustomObject]@{Name = 'Test'; Value = 42}
        PS> Test-HasProperty -Object $Object -Name 'TypeIs'
        True

        Tested the object for the presence of the Name method.  Returned True.

        .EXAMPLE
        PS> $Object = [PSCustomObject]@{Name = 'Test'; Value = 42}
        PS> Test-HasProperty -Object $Object -Name 'Sort'
        False

        Tested the object for the presence of the Name method.  Returned False.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        You may use this script only in accordance with the terms of the License Agreement that should have been included with this script.

        .LINK
        about_Advanced_FUnctions

        .LINK
        about_Advanced_Function_Parameters

        .LINK
        about_throw

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Error

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}

<#
    Test-HasProperty
#>
function Test-HasProperty {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory)]
        [PSObject]
        $Object,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [switch]
        $Strict
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if ($null -eq $Object) {
            $message = "$($CmdletName) : ArgumentNullException : The value of the Object parameter cannot be null."

            if ($Strict.IsPresent) {
                $ex = [System.ArgumentNullException]::new('Object', $message)

                Write-Error -Message $message -Exception $ex -Category InvalidArgument -TargetObject $Object -ErrorAction Continue

                throw $ex
            } else {
                Write-Warning -Message $message
                $false | Write-Output
            }
        }
    }

    PROCESS {
        $Object.PSObject.Properties | Where-Object -Property Name -EQ $Name | Write-Output
    }

    <#
        .SYNOPSIS
        Tests an object fo the presence of a property.

        .DESCRIPTION
        The `Test-HasProperty` function tests an object for the presence of a property.

        .PARAMETER Object
        Specifies the PowerShell object under test.

        .PARAMETER Name
        Specifies the name of the property to test for.

        .PARAMETER Strict
        Indicates that the function should throw an exception if the Object parameter is null.

        .INPUTS
        [string]  `Test-HasProperty` accepts a string value for the Name parameter from the PowerShell pipeline.

        .OUTPUTS
        [bool]  `Test-HasProperty` returns a boolean value indicating the presence or absence of the property.

        .EXAMPLE
        PS> $Object = [PSCustomObject]@{Name = 'Test'; Value = 42}
        PS> Test-HasProperty -Object $Object -Name 'Name'
        True

        Tested the object for the presence of the Name property.  Returned True.

        .EXAMPLE
        PS> $Object = [PSCustomObject]@{Name = 'Test'; Value = 42}
        PS> Test-HasProperty -Object $Object -Name 'Type'
        False

        Tested the object for the presence of the Name property.  Returned False.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        You may use this script only in accordance with the terms of the License Agreement that should have been included with this script.

        .LINK
        about_Advanced_FUnctions

        .LINK
        about_Advanced_Function_Parameters

        .LINK
        about_throw

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Error

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}