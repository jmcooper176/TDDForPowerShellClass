class Vine: System.IDisposable
{
    <#
        Public Properties
    #>

    <#
        Private Properties
    #>
    hidden [bool]$Disposed = $false

    <#
        Constructors
    #>
    Vine() { }

    <#
        Public Methods
    #>
    [void]Dispose() {
        $this.Dispose($true)
    }

    [void]Dispose([bool]$disposing) {
        if ($disposing -and -not $this.Disposed) {
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
    param (
        [AllowNull()]
        [object]
        $Value,

        [ValidateNotNull()]
        [type]
        $Type = [object]
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name 'CmdletName' -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand.Name

    if ($PSBoundParameters.ContainsKey('Value') -and $null -ne $Value) {
        $target = "Using Value '$($Value)' and Type '$($Type.Name)'"
    } elseif ($null -eq $Value) {
        $target = "Using Value <null> and Type '$($Type.Name)'"
    } else {
        $target = "Using No Value and Type '$($Type.Name)'"
    }

    if ($PSCmdlet.ShouldProcess($target, $CmdletName)) {
        $instance = [Vine]::new()

        if ($PSBoundParameters.ContainsKey('Value')) {
            $vine.Value = $Value
        }

        if ($PSBoundParameters.ContainsKey('Type')) {
            $instance.Type = $Type
        }

        $instance | Write-Output
    }
}