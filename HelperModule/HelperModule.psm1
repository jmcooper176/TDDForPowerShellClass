<#
    ConvertTo-Boolean
#>
function ConvertTo-Boolean {
    [CmdletBinding(DefaultParameterSetName = 'UsingObject')]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingBoolean')]
        [bool]
        $Boolean,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingByte')]
        [byte]
        $Byte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingDecimal')]
        [decimal]
        $Decimal,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingDouble')]
        [double]
        $Double,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingFloat')]
        [float]
        $Float,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingInt')]
        [int]
        $Integer,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingLong')]
        [long]
        $Long,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingObject')]
        [AllowNull()]
        [object]
        $InputObject,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingShort')]
        [short]
        $Short,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingSignedByte')]
        [sbyte]
        $SignedByte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedInteger')]
        [uint]
        $UnsignedInteger,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedLong')]
        [ulong]
        $UnsignedLong,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedShort')]
        [ushort]
        $UnsignedShort,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingString')]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Value,

        [AllowNull()]
        [cultureinfo]
        $Culture = $null
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if (-not $PSBoundParameters.ContainsKey('Culture') -or ($null -eq $Culture)) {
            $Culture = [cultureinfo]::InvariantCulture
        }
    }

    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            'UsingBoolean' {
                $Boolean | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingByte' {
                $Byte | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingDecimal' {
                $Decimal | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingDouble' {
                $Double | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingFloat' {
                $Float | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingInt' {
                $Integer | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingLong' {
                $Long | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingShort' {
                $Short | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingSignedByte' {
                $SignedByte | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingString' {
                $Value | ForEach-Object -Process { [System.Convert]::ToBoolean($_, $Culture) } | Write-Output
                break
            }

            'UsingUnsignedInteger' {
                $UnsignedInteger | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingUnsignedLong' {
                $UnsignedLong | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            'UsingUnsignedShort' {
                $UnsignedShort | ForEach-Object -Process { [System.Convert]::ToBoolean($_) } | Write-Output
                break
            }

            default {
                $InputObject | ForEach-Object -Process { [System.Convert]::ToBoolean($_, $Culture) } | Write-Output
                break
            }
        }
    }

    <#
        .SYNOPSIS
        Converts a values, strings, or objects to a boolean value.

        .DESCRIPTION
        The `ConvertTo-Boolean` function converts a values, strings, or objects to a boolean value.

        .PARAMETER Boolean
        Specifies the boolean value to convert.

        .PARAMETER Byte
        Specifies the byte value to convert.

        .PARAMETER Decimal
        Specifies the decimal value to convert.

        .PARAMETER Double
        Specifies the double value to convert.

        .PARAMETER Float
        Specifies the float value to convert.

        .PARAMETER Integer
        Specifies the integer value to convert.

        .PARAMETER Long
        Specifies the long value to convert.

        .PARAMETER Short
        Specifies the short value to convert.

        .PARAMETER SignedByte
        Specifies the signed byte value to convert.

        .PARAMETER UnsignedInteger
        Specifies the unsigned integer value to convert.

        .PARAMETER UnsignedLong
        Specifies the unsigned long value to convert.

        .PARAMETER UnsignedShort
        Specifies the unsigned short value to convert.

        .PARAMETER InputObject
        Specifies the object to convert.

        .PARAMETER Value
        Specifies the string value to convert.

        .INPUTS
        [object]  `ConvertTo-Boolean` accepts an object by value or by property name for the 'InputObject' parameter from the PowerShell pipeline.

        [bool]  `ConvertTo-Boolean` accepts a boolean value for the 'Boolean' parameter from the PowerShell pipeline.
        [byte]  `ConvertTo-Boolean` accepts a byte value for the 'Byte' parameter from the PowerShell pipeline.
        [decimal]  `ConvertTo-Boolean` accepts a decimal value for the 'Decimal' parameter from the PowerShell pipeline.
        [double]  `ConvertTo-Boolean` accepts a double value for the 'Double' parameter from the PowerShell pipeline.
        [float]  `ConvertTo-Boolean` accepts a float value for the 'Float' parameter from the PowerShell pipeline.
        [int]  `ConvertTo-Boolean` accepts an integer value for the 'Integer' parameter from the PowerShell pipeline.
        [long]  `ConvertTo-Boolean` accepts a long value for the 'Long' parameter from the PowerShell pipeline.
        [sbyte]  `ConvertTo-Boolean` accepts a signed byte value for the 'SignedByte' parameter from the PowerShell pipeline.
        [short]  `ConvertTo-Boolean` accepts a short value for the 'Short' parameter from the PowerShell pipeline.
        [string]  `ConvertTo-Boolean` accepts a string value for the 'Value' parameter from the PowerShell pipeline.
        [uint]  `ConvertTo-Boolean` accepts an unsigned integer value for the 'UnsignedInteger' parameter from the PowerShell pipeline.
        [ulong]  `ConvertTo-Boolean` accepts an unsigned long value for the 'UnsignedLong' parameter from the PowerShell pipeline.
        [ushort]  `ConvertTo-Boolean` accepts an unsigned short value for the 'UnsignedShort' parameter from the PowerShell pipeline.

        .OUTPUTS
        [bool]  `ConvertTo-Boolean` returns a boolean value to the PowerShell pipeline.

        .EXAMPLE
        PS> $Value = 'True'
        PS> ConvertTo-Boolean -Value $Value
        
        True

        Converted the string to a boolean value.  Returned the boolean value.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Advanced_FUnctions

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    ConvertTo-Byte
#>
function ConvertTo-Byte {
    [CmdletBinding(DefaultParameterSetName = 'UsingObject')]
    [OutputType([byte])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingBoolean')]
        [bool]
        $Boolean,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingByte')]
        [byte]
        $Byte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingDecimal')]
        [decimal]
        $Decimal,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingDouble')]
        [double]
        $Double,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingFloat')]
        [float]
        $Float,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingInt')]
        [int]
        $Integer,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingLong')]
        [long]
        $Long,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingObject')]
        [AllowNull()]
        [object]
        $InputObject,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingShort')]
        [short]
        $Short,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingSignedByte')]
        [sbyte]
        $SignedByte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedInteger')]
        [uint]
        $UnsignedInteger,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedLong')]
        [ulong]
        $UnsignedLong,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedShort')]
        [ushort]
        $UnsignedShort,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingString')]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Value,

        [AllowNull()]
        [cultureinfo]
        $Culture = $null
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if (-not $PSBoundParameters.ContainsKey('Culture') -or ($null -eq $Culture)) {
            $Culture = [cultureinfo]::InvariantCulture
        }
    }

    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            'UsingBoolean' {
                $Boolean | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingByte' {
                $Byte | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingChar' {
                $Character | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingDecimal' {
                $Decimal | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingDouble' {
                $Double | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingFloat' {
                $Float | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingInt' {
                $Integer | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingLong' {
                $Long | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingShort' {
                $Short | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingSignedByte' {
                $SignedByte | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingSignedByte' {
                $SignedByte | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingString' {
                $Value | ForEach-Object -Process { [System.Convert]::ToByte($_, $Culture) } | Write-Output
                break
            }

            'UsingUnsignedLong' {
                $UnsignedLong | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            'UsingUnsignedShort' {
                $UnsignedShort | ForEach-Object -Process { [System.Convert]::ToByte($_) } | Write-Output
                break
            }

            default {
                $InputObject | ForEach-Object -Process { [System.Convert]::ToByte($_, $Culture) } | Write-Output
                break
            }
        }
    }

    <#
        .SYNOPSIS
        Converts a values, strings, or objects to an unsigned byte value.

        .DESCRIPTION
        The `ConvertTo-Boolean` function converts a values, strings, or objects to an unsigned byte value.

        .PARAMETER Boolean
        Specifies the boolean value to convert.

        .PARAMETER Byte
        Specifies the byte value to convert.

        .PARAMETER Character
        Specifies the character value to convert.

        .PARAMETER Decimal
        Specifies the decimal value to convert.

        .PARAMETER Double
        Specifies the double value to convert.

        .PARAMETER Float
        Specifies the float value to convert.

        .PARAMETER Integer
        Specifies the integer value to convert.

        .PARAMETER Long
        Specifies the long value to convert.

        .PARAMETER Short
        Specifies the short value to convert.

        .PARAMETER SignedByte
        Specifies the signed byte value to convert.

        .PARAMETER UnsignedInteger
        Specifies the unsigned integer value to convert.

        .PARAMETER UnsignedLong
        Specifies the unsigned long value to convert.

        .PARAMETER UnsignedShort
        Specifies the unsigned short value to convert.

        .PARAMETER InputObject
        Specifies the object to convert.

        .PARAMETER Value
        Specifies the string value to convert.

        .INPUTS
        [object]  `ConvertTo-Byte` accepts an object by value or by property name for the 'InputObject' parameter from the PowerShell pipeline.

        [bool]  `ConvertTo-Byte` accepts a boolean value for the 'Boolean' parameter from the PowerShell pipeline.
        [byte]  `ConvertTo-Byte` accepts a byte value for the 'Byte' parameter from the PowerShell pipeline.
        [char]  `ConvertTo-Byte` accepts a character value for the 'Character' parameter from the PowerShell pipeline.
        [decimal]  `ConvertTo-Byte` accepts a decimal value for the 'Decimal' parameter from the PowerShell pipeline.
        [double]  `ConvertTo-Byte` accepts a double value for the 'Double' parameter from the PowerShell pipeline.
        [float]  `ConvertTo-Byte` accepts a float value for the 'Float' parameter from the PowerShell pipeline.
        [int]  `ConvertTo-Byte` accepts an integer value for the 'Integer' parameter from the PowerShell pipeline.
        [long]  `ConvertTo-Byte` accepts a long value for the 'Long' parameter from the PowerShell pipeline.
        [sbyte]  `ConvertTo-Byte` accepts a signed byte value for the 'SignedByte' parameter from the PowerShell pipeline.
        [short]  `ConvertTo-Byte` accepts a short value for the 'Short' parameter from the PowerShell pipeline.
        [string]  `ConvertTo-Byte` accepts a string value for the 'Value' parameter from the PowerShell pipeline.
        [uint]  `ConvertTo-Byte` accepts an unsigned integer value for the 'UnsignedInteger' parameter from the PowerShell pipeline.
        [ulong]  `ConvertTo-Byte` accepts an unsigned long value for the 'UnsignedLong' parameter from the PowerShell pipeline.
        [ushort]  `ConvertTo-Byte` accepts an unsigned short value for the 'UnsignedShort' parameter from the PowerShell pipeline.

        .OUTPUTS
        [byte]  `ConvertTo-Byte` returns a byte value to the PowerShell pipeline.

        .EXAMPLE
        PS> $Value = 'FF'
        PS> ConvertTo-Byte -Value $Value

        255

        Converted the string to a byte value.  Returned the byte value.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Advanced_FUnctions

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    ConvertTo-Char
#>
function ConvertTo-Char {
    [CmdletBinding(DefaultParameterSetName = 'UsingObject')]
    [OutputType([char])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingByte')]
        [byte]
        $Byte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingChar')]
        [char]
        $Character,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingInt')]
        [int]
        $Integer,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingLong')]
        [long]
        $Long,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingObject')]
        [AllowNull()]
        [object]
        $InputObject,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingShort')]
        [short]
        $Short,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingSignedByte')]
        [sbyte]
        $SignedByte,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedInteger')]
        [uint]
        $UnsignedInteger,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedLong')]
        [ulong]
        $UnsignedLong,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingUnsignedShort')]
        [ushort]
        $UnsignedShort,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Value,

        [AllowNull()]
        [cultureinfo]
        $Culture = $null
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if (-not $PSBoundParameters.ContainsKey('Culture') -or ($null -eq $Culture)) {
            $Culture = [cultureinfo]::InvariantCulture
        }
    }

    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            'UsingBoolean' {
                $Boolean | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingByte' {
                $Byte | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingChar' {
                $Character | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingInt' {
                $Integer | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingLong' {
                $Long | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingShort' {
                $Short | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingSignedByte' {
                $SignedByte | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingUnsignedInteger' {
                $UnsignedInteger | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingUnsignedLong' {
                $UnsignedLong | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            'UsingUnsignedShort' {
                $UnsignedShort | ForEach-Object -Process { [System.Convert]::ToChar($_) } | Write-Output
                break
            }

            default {
                $InputObject | ForEach-Object -Process { [System.Convert]::ToChar($_, $Culture) } | Write-Output
                break
            }
        }
    }

    <#
        .SYNOPSIS
        Converts a values, strings, or objects to a char value.

        .DESCRIPTION
        The `ConvertTo-Char` function converts a values, strings, or objects to a char value.

        .PARAMETER Boolean
        Specifies the boolean value to convert.

        .PARAMETER Byte
        Specifies the byte value to convert.

        .PARAMETER Character
        Specifies the character value to convert.

        .PARAMETER Integer
        Specifies the integer value to convert.

        .PARAMETER Long
        Specifies the long value to convert.

        .PARAMETER Short
        Specifies the short value to convert.

        .PARAMETER SignedByte
        Specifies the signed byte value to convert.

        .PARAMETER UnsignedInteger
        Specifies the unsigned integer value to convert.

        .PARAMETER UnsignedLong
        Specifies the unsigned long value to convert.

        .PARAMETER UnsignedShort
        Specifies the unsigned short value to convert.

        .PARAMETER InputObject
        Specifies the object to convert.

        .PARAMETER Value
        Specifies the string value to convert.

        .INPUTS
        [object]  `ConvertTo-Char` accepts an object by value or by property name for the 'InputObject' parameter from the PowerShell pipeline.

        [bool]  `ConvertTo-Char` accepts a boolean value for the 'Boolean' parameter from the PowerShell pipeline.
        [byte]  `ConvertTo-Char` accepts a byte value for the 'Byte' parameter from the PowerShell pipeline.
        [char]  `ConvertTo-Char` accepts a character value for the 'Character' parameter from the PowerShell pipeline.
        [decimal]  `ConvertTo-Char` accepts a decimal value for the 'Decimal' parameter from the PowerShell pipeline.
        [double]  `ConvertTo-Char` accepts a double value for the 'Double' parameter from the PowerShell pipeline.
        [float]  `ConvertTo-Char` accepts a float value for the 'Float' parameter from the PowerShell pipeline.
        [int]  `ConvertTo-Char` accepts an integer value for the 'Integer' parameter from the PowerShell pipeline.
        [long]  `ConvertTo-Char` accepts a long value for the 'Long' parameter from the PowerShell pipeline.
        [sbyte]  `ConvertTo-Char` accepts a signed byte value for the 'SignedByte' parameter from the PowerShell pipeline.
        [short]  `ConvertTo-Char` accepts a short value for the 'Short' parameter from the PowerShell pipeline.
        [string]  `ConvertTo-Char` accepts a string value for the 'Value' parameter from the PowerShell pipeline.
        [uint]  `ConvertTo-Char` accepts an unsigned integer value for the 'UnsignedInteger' parameter from the PowerShell pipeline.
        [ulong]  `ConvertTo-Char` accepts an unsigned long value for the 'UnsignedLong' parameter from the PowerShell pipeline.
        [ushort]  `ConvertTo-Char` accepts an unsigned short value for the 'UnsignedShort' parameter from the PowerShell pipeline.

        .OUTPUTS
        [char]  `ConvertTo-Char` returns a char value to the PowerShell pipeline.

        .EXAMPLE
        PS> $Value = 'e'
        PS> ConvertTo-Char -Value $Value
        
        e

        Converted the string to a char value.  Returned the char value.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Advanced_FUnctions

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    ConvertTo-DateTime
#>
function ConvertTo-DateTime {
    [CmdletBinding(DefaultParameterSetName = 'UsingObject')]
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingDataTime')]
        [datetime]
        $DateTime,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingObject')]
        [AllowNull()]
        [object]
        $InputObject,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Value,

        [AllowNull()]
        [cultureinfo]
        $Culture = $null
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        if (-not $PSBoundParameters.ContainsKey('Culture') -or ($null -eq $Culture)) {
            $Culture = [cultureinfo]::InvariantCulture
        }
    }

    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            'UsingDataTime' {
                $DateTime | ForEach-Object -Process { [System.Convert]::ToDateTime($_) } | Write-Output
                break
            }

            'UsingString' {
                $Value | ForEach-Object -Process { [System.Convert]::ToDateTime($_, $Culture) } | Write-Output
                break
            }

            default {
                $InputObject | ForEach-Object -Process { [System.Convert]::ToDateTime($_, $Culture) } | Write-Output
                break
            }
        }
    }

    <#
        .SYNOPSIS
        Converts values, strings, or objects to a DateTime value.

        .DESCRIPTION
        The `ConvertTo-DateTime` function converts values, strings, or objects to a DateTime value.

        .PARAMETER DateTime
        Specifies the date time value to convert.

        .PARAMETER InputObject
        Specifies the object to convert.

        .PARAMETER Value
        Specifies the string value to convert.

        .INPUTS
        [object]  `ConvertTo-DateTime` accepts an object by value or by property name for the 'InputObject' parameter from the PowerShell pipeline.

        [datetime]  `ConvertTo-DateTime` accepts a DateTime value for the 'DateTime' parameter from the PowerShell pipeline.
        [string]  `ConvertTo-Byte` accepts a string value for the 'Value' parameter from the PowerShell pipeline.

        .OUTPUTS
        [datetime]  `ConvertTo-Boolean` returns a boolean value to the PowerShell pipeline.

        .EXAMPLE
        PS> $Value = '2024-01-01'
        PS> ConvertTo-Boolean -Value $Value
        
        Monday, January 1, 2024 12:00:00 AM

        Converted the string to a DateTime value.  Returned the DateTime value.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Advanced_FUnctions

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    ConvertTo-Decimal
#>

<#
    ConvertTo-Double
#>

<#
    ConvertTo-Float
#>

<#
    ConverTo-Integer
#>

<#
    ConvertTo-Long
#>

<#
    ConvertTo-Short
#>

<#
    ConvertTo-SignedByte
#>

<#
    ConvertTo-UnsignedInteger
#>

<#
    ConvertTo-UnsignedLong
#>

<#
    ConvertTo-UnsignedShort
#>

<#
    ConvertFrom-Type
#>
function ConvertFrom-Type {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [type]
        $Type,

        [switch]
        $Name
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        if ($Name.IsPresent) {
            $Type | ForEach-Object -Process { $_.Name } | Write-Output
        }
        else {
            $Type | ForEach-Object -Process { $_.FullName } | Write-Output
        }
    }

    <#
        .SYNOPSIS
        Converts a type to a string type full name or name.

        .DESCRIPTION
        The `ConvertFrom-Type` function converts a type to a string type full name or name.

        .PARAMETER Type
        Specifies the type object to convert.

        .PARAMETER Name
        Indicates that the function should return the type name instead of the full type name.

        .INPUTS
        [type]  `ConvertFrom-Type` accepts a type object for the Type parameter from the PowerShell pipeline.

        .OUTPUTS
        [string]  `ConvertFrom-Type` returns a string type name to the PowerShell pipeline.

        .EXAMPLE
        PS> $Type = [System.String]
        PS> ConvertFrom-Type -Type $Type

        System.String

        Converted the type to a string type name.  Returned the string type name.

        .EXAMPLE
        PS> $Type = [System.String]
        PS> ConvertFrom-Type -Type $Type -Name

        String

        Converted the type to a string type name.  Returned the string type name.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_FUnctions

        .LINK
        ForEach-Object

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    ConvertTo-Type
#>
function ConvertTo-Type {
    [CmdletBinding()]
    [OutputType([type])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $TypeName
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $TypeName | ForEach-Object -Process { $_ -as [type] } | Write-Output
    }

    <#
        .SYNOPSIS
        Converts a string type name to a type.

        .DESCRIPTION
        The `ConvertTo-Type` function converts a string to a type.

        .PARAMETER TypeName
        Specifies the name or full name of the type name to convert.

        .INPUTS
        [string]  `ConvertTo-Type` accepts a string value for the TypeName parameter from the PowerShell pipeline.

        .OUTPUTS
        [type]  `ConvertTo-Type` returns a type object to the PowerShell pipeline.

        .EXAMPLE
        PS> $TypeName = 'System.String'
        PS> ConvertTo-Type -TypeName $TypeName

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     False    String                                   System.Object

        Converted the type name to a type object.  Returned the type object.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_FUnctions

        .LINK
        ForEach-Object

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    Select-ModuleByFilter
#>
function Select-ModuleByFilter {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSModuleInfo])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [SupportsWildcards()]
        [string]
        $Path,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [scriptblock]
        $FilterScript
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Path | Resolve-Path | Test-ModuleManifest | Where-Object -FilterScript $FilterScript | Write-Output
    }

    <#
        .SYNOPSIS
        Selects a module by a filter script.

        .DESCRIPTION
        The `Select-ModuleByFilter` function selects a module by a filter script.

        .PARAMETER Path
        Specifies the path to the module manifest file.

        .PARAMETER FilterScript
        Specifies the script block to use as the filter.

        .INPUTS
        [string]  `Select-ModuleByFilter` accepts a string value for the Path parameter from the PowerShell pipeline.

        .OUTPUTS
        [System.Management.Automation.PSModuleInfo]  `Select-ModuleByFilter` returns a module object to the PowerShell pipeline.

        .EXAMPLE
        PS> $Path = 'C:\Program Files\WindowsPowerShell\Modules\MyModule\MyModule.psd1'
        PS> $FilterScript = { $_.PowerShellVersion -eq '5.1' }
        PS> Select-ModuleByFilter -Path $Path -FilterScript $FilterScript
        ModuleType Version    Name ExportedCommands
        ---------- -------    ---- ----------------
        Script    1.0.0      MyModule {}

        Selected the module by the filter script.  Returned the module object.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_FUnctions
    #>
}

<#
    Select-ModuleByProperty
#>
function Select-ModuleByProperty {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSModuleInfo])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [SupportsWildcards()]
        [string]
        $Path,

        [Parameter(Mandatory)]
        [ValidateSet('Path', 'Description', 'PowerShellVersion', 'PowerShellHostName', 'PowerShellHostVersion', 'DotNetFrameworkVersion', 'ClrVersion', 'ProcessorArchitecture', 'RequiredModules', 'RequiredAssemblies', 'ScriptsToProcess', 'TypesToProcess', 'FormatsToProcess', 'NestedModules', 'FunctionsToExport', 'CmdletsToExport', 'VariablesToExport', 'AliasesToExport', 'DscResourcesToExport', 'ModuleList')]
        [string]
        $Property,

        [Parameter(Mandatory)]
        [AllowNull()]
        [object]
        $Value
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Path | Resolve-Path | Test-ModuleManifest | Where-Object -Property $Property -EQ -Value $Value | Write-Output
    }

    <#
        .SYNOPSIS
        Selects a module by a property name and value.

        .DESCRIPTION
        The `Select-ModuleByProperty` function selects a module by a property name and value.

        .PARAMETER Path
        Specifies the path to the module manifest file.

        .PARAMETER Property
        Specifies the name of the property to test for equality.

        .PARAMETER Value
        Specifies the value of the property to test for equality.

        .INPUTS
        [string]  `Select-ModuleByProperty` accepts a string value for the Path parameter from the PowerShell pipeline.

        .OUTPUTS
        [System.Management.Automation.PSModuleInfo]  `Select-ModuleByProperty` returns a module object to the PowerShell pipeline.

        .EXAMPLE
        PS> $Path = 'C:\Program Files\WindowsPowerShell\Modules\MyModule\MyModule.psd1'
        PS> Select-ModuleByProperty -Path $Path -Property 'PowerShellVersion' -Value '5.1'
        ModuleType Version    Name ExportedCommands
        ---------- -------    ---- ----------------
        Script    1.0.0      MyModule {}

        Selected the module by the property value.  Returned the module object.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_FUnctions
    #>
}

<#
    Select-ModuleProperty
#>
function Select-ModuleProperty {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [SupportsWildcards()]
        [string]
        $Path,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateSet('Path', 'Description', 'PowerShellVersion', 'PowerShellHostName', 'PowerShellHostVersion', 'DotNetFrameworkVersion', 'ClrVersion', 'ProcessorArchitecture', 'RequiredModules', 'RequiredAssemblies', 'ScriptsToProcess', 'TypesToProcess', 'FormatsToProcess', 'NestedModules', 'FunctionsToExport', 'CmdletsToExport', 'VariablesToExport', 'AliasesToExport', 'DscResourcesToExport', 'ModuleList')]
        [string[]]
        $Property
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Path | Resolve-Path | Test-ModuleManifest | Select-Object -Property $Property | Write-Output
    }

    <#
        .SYNOPSIS
        Selects a module property(s) or property expression(s).

        .DESCRIPTION
        The `Select-ModuleProperty` function selects a module property(s) or property expression(s)..

        .PARAMETER Path
        Specifies the path to the module manifest file.

        .PARAMETER Property
        Specifies the name of the property to select.

        .INPUTS
        [string]  `Select-ModuleProperty` accepts a string value for the Path parameter from the PowerShell pipeline.

        .OUTPUTS
        [bool]  `Select-ModuleProperty` returns a boolean value indicating the presence or absence of the property.

        .EXAMPLE
        PS> $Path = 'C:\Program Files\WindowsPowerShell\Modules\MyModule\MyModule.psd1'
        PS> Select-ModuleProperty -Path $Path -Property 'PowerShellVersion'
        5.1

        Selected the module property.  Returned the property value.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_FUnctions
    #>
}

<#
    Test-HasMethod
#>
function Test-HasMember {
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
            }
            else {
                Write-Warning -Message $message
                $false | Write-Output
            }
        }
    }

    PROCESS {
        if ($null -ne $Object) {
            $Object.PSObject.Members | Where-Object -Property Name -EQ $Name | Write-Output
        }
        else {
            $false | Write-Output
        }
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
            }
            else {
                Write-Warning -Message $message
                $false | Write-Output
            }
        }
    }

    PROCESS {
        if ($null -ne $Object) {
            $Object.PSObject.Methods | Where-Object -Property Name -EQ $Name | Write-Output
        }
        else {
            $false | Write-Output
        }
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
            }
            else {
                Write-Warning -Message $message
                $false | Write-Output
            }
        }
    }

    PROCESS {
        if ($null -ne $Object) {
            $Object.PSObject.Properties | Where-Object -Property Name -EQ $Name | Write-Output
        }
        else {
            $false | Write-Output
        }
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

<#
    Test-ModuleProperty
#>
function Test-ModuleProperty {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [SupportsWildcards()]
        [string]
        $Path,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateSet('Path', 'Description', 'PowerShellVersion', 'PowerShellHostName', 'PowerShellHostVersion', 'DotNetFrameworkVersion', 'ClrVersion', 'ProcessorArchitecture', 'RequiredModules', 'RequiredAssemblies', 'ScriptsToProcess', 'TypesToProcess', 'FormatsToProcess', 'NestedModules', 'FunctionsToExport', 'CmdletsToExport', 'VariablesToExport', 'AliasesToExport', 'DscResourcesToExport', 'ModuleList')]
        [string[]]
        $Property
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Result = $Path | Resolve-Path |
        Test-ModuleManifest |
        Select-Object -Property $Property |
        Measure-Object -Property $Property |
        Where-Object -Property Count -GT 0

        if ($Result) {
            $true | Write-Output
        }
        else {
            $false | Write-Output
        }
    }
}
