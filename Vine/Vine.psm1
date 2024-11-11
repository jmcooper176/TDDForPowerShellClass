<#
    class Vine
#>
class Vine: System.IDisposable
{
    <#
        Public Properties
    #>
    [Type]$Type = [object]

    [AllowNull()]
    [object]$Value

    <#
        Private Properties
    #>
    hidden [bool]$Disposed = $false

    <#
        Constructors
    #>
    Vine()
    {
        $this.Type = [object] -as [Type]
        $this.Value = $null
    }

    Vine([object]$Value)
    {
        $this.Type = $Value.GetType()
        $this.Value = $Value -as $this.Type
    }

    Vine([Type]$Type)
    {
        $this.Type = $Type
        $this.Value = $null
    }

    Vine([object]$Value, [Type]$Type)
    {
        $this.Type = $Type
        $this.Value = $Value -as $this.Type
    }

    <#
        Public Methods
    #>
    [void]Dispose() {
        $this.Dispose($true)
    }

    # override from here
    [void]Dispose([bool]$disposing) {
        if ($disposing -and -not $this.Disposed) {
            $this.Value = $null
            $this.Type = [object] -as [Type]
            $this.Disposed = $true
        }
    }

    <#
        Static Methods
    #>
    static [void]Swap([Vine]$First, [Vine]$Second)
    {
        $temp = $First.Value
        $First.Emplace($Second.Value)
        $Second.Emplace($temp)
    }
}

<#
    New-Vine
#>
function New-Vine {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([Vine])]
    param (
        [AllowNull()]
        [object]
        $Value = $null,

        [ValidateNotNull()]
        [type]
        $Type = [object]
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name 'CmdletName' -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand.Name -WhatIf:$false

    if ($PSBoundParameters.ContainsKey('Value')) {
        if ($null -ne $Value) {
            $target = "Using Value '$($Value)' and Type '$($Type.Name)'"
        } else {
            $target = "Using Value <null> and Type '$($Type.Name)'"
        }
    } else {
        $target = "Using Value <null> and Type '$($Type.Name)'"
    }

    if ($PSCmdlet.ShouldProcess($target, $CmdletName)) {
        $instance = [Vine]::new()

        $instance.Type = $Type

        if ($PSBoundParameters.ContainsKey('Value')) {
            $instance.Value = $Value -as $instance.Type
        }

        $instance | Write-Output
    } else {
        Write-Warning -Message "$($CmdletName) : WhatIf Passed : $target"
        $null | Write-Output
    }

    <#
        .SYNOPSIS
        Creates a new instance of the Vine class.

        .DESCRIPTION
        `New-Vine` Creates a new instance of the Vine class.

        .PARAMETER Value
        Specifies the value to use for the new instance.  May be null.

        .PARAMETER Type
        Specifies the type to use for the new instance.  Defaults to [object].

        .INPUTS
        None.  You cannot pipe objects to `New-Vine`.

        .OUTPUTS
        [Vine].  A new instance of the Vine class.

        .EXAMPLE
        PS C: \> New-Vine -Value 'Hello, World!' -Type [string]
        
        Creates a new instance of the Vine class with the value 'Hello, World!' and the type [string].

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        You may use this script only in accordance with the terms of the License Agreement that should have been included with this script.

        .LINK
        about_Advanced_FUnctions

        .LINK
        about_Advanced_Function_Parameters

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
