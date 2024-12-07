using namespace System

<#
    class Vine
#>
class Vine : System.IDisposable
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
    hidden [bool]$Disposed

    <#
        Constructors
    #>
    Vine()
    {
        $constructorHashTable = @{
            Type = [object]
            Value = $null
        }

        $this.Initialize($constructorHashTable)
    }

    Vine([Type]$Value)
    {
        $constructorHashTable = @{
            Type = $Value.GetType()
            Value = $Value
        }
        
        $this.Initialize($constructorHashTable)
    }

    Vine([object]$Value, [Type]$Type)
    {
        $constructorHashTable = @{
            Type = $Type
            Value = $Value
        }

        $this.Initialize($constructorHashTable)
    }

    Vine([hashtable]$properties)
    {
        $this.Initialize($properties)
    }

    # Hidden Public method to share code between constructors
    hidden [void]Initialize([hashtable]$properties)
    {
        if (-not $properties.ContainsKey('Type')) {
            $properties.Add('Type', [type][object])
        }

        if (-not $properties.ContainsKey('Value')) {
            $properties.Add('Value', $null)
        }

        $this.Disposed = $false
        $this.Type     = $properties['Type']
        $this.Value    = $properties['Value']
    }

    <#
        Public Methods
    #>
    [type]AsType()
    {
        return $this.Type
    }

    [object]Cast([Type]$Type)
    {
        return [Convert]::ChangeType($this.Value, $Type)
    }
    
    [void]Dispose() {
        $this.Dispose($true)
    }

    # override from here
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

    [void]Emplace([object]$Value)
    {
        $this.Value = $Value
    }

    [void]Emplace([object]$Value, [Type]$Type)
    {
        $this.Value = $Value
        $this.Type = $Type
    }

    [void]Emplace([Vine]$other)
    {
        $this.Value = $other.Value
        $this.Type = $other.Type
    }
    
    [bool]Equals([Vine]$other)
    {
        if ($null -eq $other) {
            return $false
        }

        if ($this.Type -ne $other.Type) {
            return $false
        }

        if ($this.Value -ne $other.Value) {
            return $false
        }

        return $true
    }

    [int]GetHashCode()
    {
        return [Tuple]::Create($this.Value, $this.Type).GetHashCode()
    }

    [bool]HasValue()
    {
        return $null -ne $this.Value
    }

    [bool]NotEquals([Vine]$other)
    {
        return -not $this.Equals($other)
    }

    [string]ToString()
    {
        return ('{0} as <{1}>' -f $this.Value, $this.Type.FullName)
    }

    <#
        Static Methods
    #>
    static [type]BaseType([Vine]$other)
    {
        return $other.Type.BaseType
    }

    static [bool]CanConvert([Vine]$other, [Type]$Type)
    {
        return $other.Type -as $Type
    }

    static [type]DeclaringType([Vine]$other)
    {
        return $other.Type.DeclaringType
    }

    static [bool]Equals([Vine]$First, [Vine]$Second)
    {
        if ($null -eq $First) {
            return $false
        }

        return $First.Equals($Second)
    }

    static [bool]HasElementType([Vine]$other)
    {
        return $other.Type.HasElementType
    }

    static [bool]IsAssignableFrom([Vine]$First, [Vine]$Second)
    {
        return $First.Type.IsAssignableFrom($Second.Type)
    }

    static [bool]IsAssignableTo([Vine]$First, [Vine]$Second)
    {
        return $First.Type.IsAssignableFrom($Second.Type)
    }

    static [bool]IsClass([Vine]$other)
    {
        return $other.Type.IsClass
    }

    static [bool]IsInstanceOfType([Vine]$First, [Vine]$Second)
    {
        return $First.Type.IsInstanceOfType($Second.Value)
    }

    static [bool]IsSubclassOf([Vine]$First, [Vine]$Second)
    {
        return $First.Type.IsSubclassOf($Second.Type)
    }

    static [bool]IsValueType([Vine]$other)
    {
        return $other.Type.IsValueType
    }

    static [bool]NotEquals([Vine]$First, [Vine]$Second)
    {
        return -not $First.Equals($Second)
    }

    static [void]Swap([Vine]$First, [Vine]$Second)
    {
        $swapValue = $First.Value

        $First.Emplace($Second.Value)
        $Second.Emplace($swapValue)
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
