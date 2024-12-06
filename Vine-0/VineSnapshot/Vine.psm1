<#
    class Vine
#>
class Vine : System.IDisposable
{
    <#
        Public Properties
    #>

    <#
        Hidden Public Properties
    #>
    hidden [bool]$Disposed

    <#
        Constructors
    #>
    Vine() {
        $this.Initialize(@{})
    }

    # Hidden Public method to share code between constructors
    hidden [void]Initialize([hashtable]$properties) {
        $this.Disposed = $false
    }

    <#
        Public Methods
    #>
    [void]Dispose() {
        $this.Dispose($true)
    }

    # override only this Dispose() method
    [void]Dispose([bool]$disposing) {
        if (-not $this.Disposed) {
            if ($disposing) {
                # Dispose managed resources
            }

            # Dispose unmanaged resources
            $this.Disposed = $true
        }
    }

    <#
        Static Methods
    #>
}

<#
    New-Vine
#>
function New-Vine {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([Vine])]
    param ()

    Set-StrictMode -Version 3.0
    Set-Variable -Name 'CmdletName' -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand.Name -WhatIf:$false

    if ($PSCmdlet.ShouldProcess('Default Constructor', $CmdletName)) {
        [Vine]::new() | Write-Output
    }

    <#
        .SYNOPSIS
        Creates a new instance of the Vine class.

        .DESCRIPTION
        `New-Vine` Creates a new instance of the Vine class.

        .INPUTS
        None.  You cannot pipe objects to `New-Vine`.

        .OUTPUTS
        [Vine].  A new instance of the Vine class.

        .EXAMPLE
        PS C: \> New-Vine
        
        Creates a new instance of the Vine class.

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
    #>
}
