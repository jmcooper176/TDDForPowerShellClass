<#
    Vine Pester Tests Based on the Pester Framework and STL Any Class

    https://learn.microsoft.com/en-us/cpp/standard-library/any-class?view=msvc-170#members
#>

BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath "Vine\Vine.psm1" -Resolve
    Import-Module -Name $ModulePath -Force

    Set-Variable -Name TheAnswer -Option Constant -Value 42
    Set-Variable -Name LuckyNumber -Option Constant -Value 7
    Set-Variable -Name UnluckyNumber -Option Constant -Value 13

    $TestData = @(
        [PSCustomObject]@{Name = 'NormalAnswer'; Value = $TheAnswer; Type = [int];},
        [PSCustomObject]@{Name = 'NormalLucky'; Value = $LuckyNumber; Type = [int];},
        [PSCustomObject]@{Name = 'NormalUnlucky'; Value = $UnluckyNumber; Type = [int];},
        [PSCustomObject]@{Name = 'LongAnswer'; Value = [long]$TheAnswer; Type = [long];},
        [PSCustomObject]@{Name = 'LongLucky'; Value = [long]$LuckyNumber; Type = [long];},
        [PSCustomObject]@{Name = 'LongUnlucky'; Value = [long]$UnluckyNumber; Type = [long];},
        [PSCustomObject]@{Name = 'DoubleAnswer'; Value = $TheAnswer * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'DoubleLucky';Value = $LuckyNumber * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'DoubleUnlucky'; Value = $UnluckyNumber * 1.0; Type = [double];},
        [PSCustomObject]@{Name = 'NegativeAnswer'; Value = -$TheAnswer; Type = [int];},
        [PSCustomObject]@{Name = 'NegativeLucky'; Value = -$LuckyNumber; Type = [int];},
        [PSCustomObject]@{Name = 'NegativeUnlucky'; Value = -$UnluckyNumber; Type = [int];},
        [PSCustomObject]@{Name = 'StringAnswer'; Value = [string]$TheAnswer; Type = [string];},
        [PSCustomObject]@{Name = 'StringLucky'; Value = [string]$LuckyNumber; Type = [string];},
        [PSCustomObject]@{Name = 'StringUnlucky'; Value = [string]$UnluckyNumber; Type = [string];}
    )
}

Describe -Name "Vine Class" -Tag "Red Green Tests" {
    Describe -Name "Vind Constructor" -Tag "Constructor Tests" {
        It -Name "Should be able to create a Vine" -Tag "Unit Test" {
            # Arrange, Act, and Assert
            { $vine = [Vine]::new() } | Should -Not -Throw

            # Assert
            $vine | Should -Not -BeNullOrEmpty
            $vine | Should -BeOfType [Vine]
        }

        It -Name "Should be able to create a Vine with a value" -Tag "Unit Test" {
            # Arrange, Act, and Assert
            { $vine = [Vine]::new($TheAnswer) } | Should -Not -Throw

            # Assert
            $vine | Should -Not -BeNullOrEmpty
            $vine | Should -BeOfType [Vine]
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            $vine.Value | Should -Be $TheAnswer
        }

        It -Name "Should be able to create a Vine with a value and a type" -Tag "Unit Test" {
            # Arrange, Act, and Assert
            { $vine = [Vine]::new($TheAnswer) } | Should -Not -Throw

            # Assert
            $vine | Should -Not -BeNullOrEmpty
            $vine | Should -BeOfType [Vine]
            Test-HasProperty -Object $vine -Name 'Value' | Should -BeTrue
            Test-HasProperty -Object $vine -Name 'Type' | Should -BeTrue
            $vine.Value | Should -Be $TheAnswer
            $vine.Type | Should -Be [int]
        }
    }
    
    Describe -Name "Vine Method Emplace" -Tag "Method Emplace Tests" {
        It -Name "Should be able to create a Vine with a value and a type and emplace a new value" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.Emplace($LuckyNumber) | Should -Be $LuckyNumber
        }
    }

    Describe -Name "View Method Equals" -Tag "Method Equals Tests" {
        It -Name "Should be able to create a Vine with a value and another vine with the same value and compare them for equality" -Tag "Unit Test" {
            # Arrange
            $left  = [Vine]::new($TheAnswer, [int])
            $right = [Vine]::new($TheAnswer, [int])
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name "Should be able to create a Vine with a value and another vine with a different value and compare them for inequality" -Tag "Unit Test" {
            # Arrange
            $left  = [Vine]::new($TheAnswer, [int])
            $right = [Vine]::new($LuckyNumber, [int])
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name "Should be able to create a Vine without a value and another vine without a value and compare them for equality" -Tag "Unit Test" {
            # Arrange
            $left  = [Vine]::new()
            $right = [Vine]::new()
            
            # Act and Assert
            $left.Equals($right) | Should -BeTrue
        }
    
        It -Name "Should be able to create a Vine with a value and another vine without a value and compare them for inequality" -Tag "Unit Test" {
            # Arrange
            $left  = [Vine]::new($TheAnswer, [int])
            $right = [Vine]::new()
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    
        It -Name "Should be able to create a Vine without a value and another vine with a value and compare them for inequality" -Tag "Unit Test" {
            # Arrange
            $left  = [Vine]::new()
            $right = [Vine]::new($TheAnswer, [int])
            
            # Act and Assert
            $left.Equals($right) | Should -BeFalse
        }
    }

    Describe -Name "Vine Method GetType" -Tag "Method GetType Tests" {
        It -Name "Should be able to create a Vine with a value and a type and get the type" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.GetType() | Should -Be [int]
        }
    }

    Describe -Name "Vine Method GetValue" -Tag "Method GetValue Tests" {
        It -Name "Should be able to create a Vine with a value and a type and get the value" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name "Should be able to create a Vine with a value and a type and get the value" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.GetValue() | Should -Be $TheAnswer
        }

        It -Name "Should be able to create a Vine with a value and a type and get the value as a different type" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.GetValue([string]) | Should -Be $TestData[12].Value
        }
    }

    Describe -Name "Vine Method HasVelue" -Tag "Method HasValue Tests" {
        It -Name "Should be able to create a Vine with a value and a type and has value should be true" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new($TheAnswer, [int])

            # Act and Assert
            $vine.HasValue() | Should -BeTrue
        }
    
        It -Name "Should be able to create a Vine without a value and has value should be false" -Tag "Unit Test" {
            # Arrange
            $vine = [Vine]::new()

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
        PS> Test-HasProperty -Object $Object -Name 'GetType'
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