
<#
    Test-HasMethod
#>
function Test-HasMethod {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory)]
        [AllowNull()]
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
        [AllowNull()]
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