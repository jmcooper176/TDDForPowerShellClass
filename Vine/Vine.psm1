using namespace System

<#
    class Vine
#>
class Vine : System.IDisposable {
    <#
        Public Properties
    #>
    [type]$Type = [object]

    [AllowNull()]
    [object]$Value

    <#
        Static Public Properties
    #>
    static [type]$ClassType   = [Vine].AsType()
    static [string]$FullName  = [Vine].FullName
    static [string]$Name      = [Vine].Name
    static [string]$Namespace = [Vine].Namespace

    <#
        Private Properties
    #>
    hidden [bool]$Disposed

    <#
        Constructors
    #>
    Vine() {
        $this.Initialize(@{})
    }

    Vine([Type]$Value) {
        $this.Initialize(@{Type = $Value.GetType(); Value = $Value })
    }

    Vine([hashtable]$Properties) {
        $this.Initialize($Properties)
    }

    Vine([object]$Value, [Type]$Type) {
        $this.Initialize(@{Type = $Type; Value = $Value })
    }

    # Hidden Public method to share code between constructors
    hidden [void]Initialize([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    
        $this.Disposed = $false
    }

    <#
        Public Methods
    #>
    [void]Dispose() {
        $this.Dispose($true)
    }

    # override this Dispose method to clean up resources
    [void]Dispose([bool]$disposing) {
        if (-not $this.Disposed) {
            if ($disposing) {
                # managed cleanup here
                $this.Value = $null
                $this.Type = [object]
            }

            # unmanaged cleanup here

            $this.Disposed = $true
        }
    }
}

<#
    Initialization Script
#>
# Define the types to export with type accelerators.
[type[]]$ExportableTypes =@([Vine])

# Get the internal TypeAccelerators class to use its static methods.
$TypeAcceleratorsClass = [psobject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators'
)

# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get

$ExportableTypes | ForEach-Object -Process {
    $Type = $_

    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' : '

        throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'Vine-ResourceUnavailable-01',
            'InvalidOperation',
            $Type.FullName
        )
    }
}

# Add type accelerators for every exportable type.
$ExportableTypes | ForEach-Object -Process {
    $Type = $_
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}

# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    $ExportableTypes | ForEach-Object -Process {
        $Type = $_
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()

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

    if (($null -ne $Value) -or ($Type -ne [object])) {
        if ($PSCmdlet.ShouldProcess('Value and Type Constructor', $CmdletName)) {
            [Vine]::new($Value, $Type) | Write-Output
        }
    }
    elseif ($null -ne $Value) {
        if ($PSCmdlet.ShouldProcess('Value Constructor', $CmdletName)) {
            [Vine]::new($Value) | Write-Output
        }
    }
    else {
        if ($PSCmdlet.ShouldProcess('Default Constructor', $CmdletName)) {
            [Vine]::new() | Write-Output
        }
    }

    <#
        .SYNOPSIS
        Creates a new instance of the Vine class.

        .DESCRIPTION
        `New-Vine` Creates a new instance of the Vine class.

        .PARAMETER InvocationInfo
        Specifies the invocation information for the cmdlet for registering the type accelerator.

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
