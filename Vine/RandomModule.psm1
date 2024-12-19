<#
    Script-scoped variables
#>
$IntegerArray = @()

$FloatArray = @()

$DoubleArray = @()

$LongArray = @()

$IsInitialized = $false

<#
Get-RandomDouble
#>
function Get-RandomDouble {
    [CmdletBinding()]
    [OutputType([double])]
    param ()

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    if (-not $Script:IsInitialized) {
        Write-Warning -Message "$($CmdletName): Random number generator has not been initialized. Initializing now."
        Initialize-Random
    }

    $index = $Random.Next(0, $Script:DoubleLength)

    try {
        $Script:DoubleArray[$index] | Write-Output
    }
    finally {
        $Script:DoubleArray[$index] = $Random.NextDouble()
    }

    <#
        .SYNOPSIS
        Generates a random double-precision floating-point number.

        .DESCRIPTION
        Generates a random double-precision floating-point number between 0.0 and 1.0.

        .INPUTS
        None.  You cannot pipe objects to Get-RandomDouble.

        .OUTPUTS
        [double].  Get-RandomDouble generates a random double-precision floating-point number.

        .EXAMPLE
        PS> Get-RandomDouble

        0.123456789

        Generates a random double-precision floating-point number between 0.0 and 1.0.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Initialize-Random

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}

<#
Get-RandomInteger
#>
function Get-RandomInteger {
    [CmdletBinding()]
    [OutputType([int])]
    param (
        [ValidateRange(-2147483648, 2147483647)]
        [int]
        $Minimum = 0,

        [ValidateRange(-2147483648, 2147483647)]
        [int]
        $Maximum = 2147483647
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    if (-not $Script:IsInitialized) {
        Write-Warning -Message "$($CmdletName): Random number generator has not been initialized. Initializing now."
        Initialize-Random
    }

    $index = $Random.Next(0, $Script:IntLength - 1)

    try {
        $Script:IntegerArray[$index] % ($Maximum - $Minimum + 1) + $Minimum | Write-Output
    }
    finally {
        $Script:IntegerArray[$index] = $Random.Next()
    }

    <#
        .SYNOPSIS
        Generates a random integer.

        .DESCRIPTION
        Generates a random integer between the specified minimum and maximum values.  If no minimum and maximum values are specified, the range is from 0 to 2147483647.

        .PARAMETER Minimum
        The minimum value of the random integer.

        .PARAMETER Maximum
        The maximum value of the random integer.

        .INPUTS
        None.  You cannot pipe objects to Get-RandomInteger.

        .OUTPUTS
        [int].  Get-RandomInteger generates a random integer.

        .EXAMPLE
        PS> Get-RandomInteger

        123456789

        Generates a random integer between 0 and 2147483647.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Initialize-Random

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}

<#
Get-RandomFloat
#>
function Get-RandomFloat {
    [CmdletBinding()]
    [OutputType([float])]
    param ()

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    if (-not $Script:IsInitialized) {
        Write-Warning -Message "$($CmdletName): Random number generator has not been initialized. Initializing now."
        Initialize-Random
    }

    $index = $Random.Next(0, $Script:FloatLength - 1)

    try {
        $Script:FloatArray[$index] | Write-Output
    }
    finally {
        $Script:FloatArray[$index] = $Random.NextSingle()
    }

    <#
        .SYNOPSIS
        Generates a random floating-point number.

        .DESCRIPTION
        Generates a random floating-point number between 0.0 and 1.0.
        
        .INPUTS
        None.  You cannot pipe objects to Get-RandomFloat.

        .OUTPUTS
        [float].  Get-RandomFloat generates a random floating-point number.

        .EXAMPLE
        PS> Get-RandomFloat

        0.123456789

        Generates a random floating-point number between 0.0 and 1.0.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Initialize-Random

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}

<#
Get-RandomInteger
#>
function Get-RandomLong {
    [CmdletBinding()]
    [OutputType([long])]
    param (
        [ValidateRange(-9223372036854775808, 9223372036854775807)]
        [long]
        $Minimum = 0,

        [ValidateRange(-9223372036854775808, 9223372036854775807)]
        [long]
        $Maximum = 9223372036854775807
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    if (-not $Script:IsInitialized) {
        Write-Warning -Message "$($CmdletName): Random number generator has not been initialized. Initializing now."
        Initialize-Random
    }

    $index = $Random.Next(0, $Script:LongLength - 1)

    try {
        $Script:LongArray[$index] % ($Maximum - $Minimum + 1) + $Minimum | Write-Output
    }
    finally {
        $Script:LongArray[$index] = $Random.NextLong()
    }

    <#
        .SYNOPSIS
        Generates a random long integer.

        .DESCRIPTION
        Generates a random long integer between the specified minimum and maximum values.  If no minimum and maximum values are specified, the range is from 0 to 9223372036854775807.

        .PARAMETER Minimum
        The minimum value of the random long integer.

        .PARAMETER Maximum
        The maximum value of the random long integer.

        .INPUTS
        None.  You cannot pipe objects to Get-RandomLong.

        .OUTPUTS
        [long].  Get-RandomLong generates a random long integer.

        .EXAMPLE
        PS> Get-RandomLong

        4567890123456789

        Generates a random long integer between 0 and 9223372036854775807.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Initialize-Random

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output

        .LINK
        Write-Warning
    #>
}

<#
    Initialize-Random
#>
function Initialize-Random {
    [CmdletBinding()]
    param (
        [ValidateRange(-2147483648, 2147483647)]
        [int]
        $Seed,

        [switch]
        $DefaultSeed
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    if (-not $PSBoundParameters.ContainsKey('Seed') -and -not $DefaultSeet.IsPresent) {
        $Seed = [Convert]::ToInt32([DateTime]::UtcNow.Ticks)
    }
    elseif ($DefaultSeed.IsPresent) {
        $Seed = 0
    }

    [Random]::new($Seed) | Set-Variable -Name Random -Option ReadOnly -Scope Script
    Set-Variable -Name IntLength -Option Constant -Value 1021 -Scope Script
    Set-Variable -Name FloatLength -Option Constant -Value 1021 -Scope Script
    Set-Variable -Name DoubleLength -Option Constant -Value 509 -Scope Script
    Set-Variable -Name LongLength -Option Constant -Value 509 -Scope Script

    for ($i = 0; $i -lt $Script:IntLength; $i++) {
        $IntegerArray[$i] = $Random.Next()
    }

    for ($i = 0; $i -lt $Script:FloatLength; $i++) {
        $floatArray[$i] = $Random.NextSingle()
    }

    for ($i = 0; $i -lt $Script:DoubleLength; $i++) {
        $doubleArray[$i] = $Random.NextDouble()
    }

    for ($i = 0; $i -lt $Script:LongLength; $i++) {
        $longArray[$i] = $Random.NextLong()
    }

    $Script:IsInitialized = $true

    <#
        .SYNOPSIS
        Initializes the random number generator.

        .DESCRIPTION
        Initializes the random number generator with the specified seed. If no seed is specified, the current time in ticks convert to an integer is used as the seed.  If '-DefaultSeed' is specified, the seed is set to 0.

        .PARAMETER Seed
        The seed to use for the random number generator.

        .PARAMETER DefaultSeed
        Use the default seed of 0.

        .INPUTS
        None.  You cannot pipe objects to Initialize-Random.

        .OUTPUTS
        None.  Initialize-Random does not generate any output.

        .EXAMPLE
        PS> Initialize-Random -Seed 12345

        Initializes the random number generator with a seed of 12345.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}