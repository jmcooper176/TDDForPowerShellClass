<#
    Add-TypeAccelerator
#>
function Add-TypeAccelerator {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [type[]]
        $ExportableType
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand -WhatIf:$false

        $TypeAcceleratorsClass = Get-TypeAcceleratorClass
    }

    PROCESS {
        # Add type accelerators for every exportable type.
        $ExportableType | ForEach-Object -Process {
            if ($PSCmdlet.ShouldProcess($_.FullName, $CmdletName)) {
                $TypeAcceleratorsClass::Add($_.FullName, $_)
            }
        }
    }

    <#
        .SYNOPSIS
        Add exportable types as type accelerators.

        .DESCRIPTION
        `Add-TypeAccelerator` adds exportable types as type accelerators to the current session.

        .PARAMETER ExportableType
        Specifies the exportable types to add as type accelerators.

        .INPUTS
        System.Type[]  You can pipe types to `Add-TypeAccelerator`.

        .OUTPUTS
        None.  `Add-TypeAccelerator` does not generate any output.

        .EXAMPLE
        PS> [Vine] | Add-TypeAccelerator

        This command adds the `[Vine]` type as a type accelerator to the current session.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        The type accelerator is removed when the module is removed.

        The type accelerator is not added if it is already registered.

        The type accelerator is not added if the `-WhatIf` common parameter is used.

        The type accelerator is not added if the `-Confirm` common parameter is used and the user does not confirm the operation.

        .LINK
        about_Advanced_Function

        .LINK
        ForEach-Object

        .LINK
        Get-TypeAcceleratorClass

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    Get-TypeAccelerator
#>
function Get-TypeAccelerator {
    [CmdletBinding(DefaultParameterSetName = 'UsingTypeName')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingTypeName')]
        [string[]]
        $TypeName,

        [Parameter(Mandatory, ParameterSetName = 'UsingListAvailable')]
        [switch]
        $ListAvailable
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand

        $TypeAcceleratorsClass = Get-TypeAcceleratorClass
    }

    PROCESS {
        # Get the type accelerator for every type name.
        if ($ListAvailable.IsPresent) {
            $TypeAcceleratorsClass::Get | Write-Output
        }
        else {
            $TypeAcceleratorsClass::Get | ForEach-Object -Process {
                if ($_.Key -in $TypeName) {
                    $_ | Write-Output
                }
            }
        }
    }

    <#
        .SYNOPSIS
        Get type accelerators.

        .DESCRIPTION
        `Get-TypeAccelerator` gets type accelerators from the current session.

        .PARAMETER TypeName
        Specifies the type full names of the type accelerators to get.

        .PARAMETER ListAvailable
        Lists all available type accelerators.

        .INPUTS
        System.String[]  You can pipe type full names to `Get-TypeAccelerator`.

        .OUTPUTS
        System.Collections.Generic.Dictionary`2[System.String,System.Type]  `Get-TypeAccelerator` returns a dictionary of type accelerators.

        .EXAMPLE
        PS> Get-TypeAccelerator -ListAvailable | Format-Table

        This command lists all available type accelerators in the current session.

        .EXAMPLE
        PS> Get-TypeAccelerator -TypeName 'Vine' | Format-Table

        This command gets the type accelerator for the `Vine` type in the current session.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_Function

        .LINK
        ForEach-Object

        .LINK
        Get-TypeAcceleratorClass

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    Get-TypeAcceleratorClass
#>
function Get-TypeAcceleratorClass {
    [CmdletBinding()]
    param ()

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand

    # Get the internal TypeAccelerators class to use its static methods.
    [psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators') | Write-Output

    <#
        .SYNOPSIS
        Get the internal TypeAccelerators class.

        .DESCRIPTION
        `Get-TypeAcceleratorClass` gets the internal TypeAccelerators class to use its static methods.

        .INPUTS
        None.  You cannot pipe objects to `Get-TypeAcceleratorClass`.

        .OUTPUTS
        System.Type  `Get-TypeAcceleratorClass` returns the internal TypeAccelerators class.

        .EXAMPLE
        PS> Get-TypeAcceleratorClass

        This command gets the internal TypeAccelerators class to use its static methods.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_Function

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    Register-TypeAccelerator
#>
function Register-TypeAccelerator {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [type[]]
        $ExportableType
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand -WhatIf:$false
    }

    PROCESS {
        # Add type accelerators for every exportable type.
        $ExportableType | Where-Object -FilterScript {
            -not (Test-TypeAcceleratorRegistered -ExportableType $_)
        } | ForEach-Object -Process {
            if ($PSCmdlet.ShouldProcess($_.FullName, $CmdletName)) {
                $_ | Add-TypeAccelerator

                # Remove type accelerators when the module is removed.
                $MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
                    $_ | Remove-TypeAccelerator
                }.GetNewClosure()
            }
        }
    }

    <#
        .SYNOPSIS
        Register exportable types as type accelerators.

        .DESCRIPTION
        `Register-TypeAccelerator` registers exportable types as type accelerators to the current session.

        .PARAMETER ExportableType
        Specifies the exportable types to register as type accelerators.

        .INPUTS
        System.Type[]  You can pipe types to `Register-TypeAccelerator`.

        .OUTPUTS
        None.  `Register-TypeAccelerator` does not generate any output.

        .EXAMPLE
        PS> [Vine] | Register-TypeAccelerator

        This command registers the `[Vine]` type as a type accelerator to the current session.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        The type accelerator is removed when the module is removed.

        The type accelerator is not registered if it is already registered.

        The type accelerator is not registered if the `-WhatIf` common parameter is used.

        The type accelerator is not registered if the `-Confirm` common parameter is used and the user does not confirm the operation.

        .LINK
        about_Advanced_Function

        .LINK
        Add-TypeAccelerator

        .LINK
        ForEach-Object

        .LINK
        Remove-TypeAccelerator

        .LINK
        Test-TypeAcceleratorRegistered

        .LINK
        Where-Object
    #>
}

<#
    Remove-TypeAccelerator
#>
function Remove-TypeAccelerator {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [type[]]
        $ExportableType
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand -WhatIf:$false

        # Get the internal TypeAccelerators class to use its static methods.
        $TypeAcceleratorsClass = Get-TypeAcceleratorClass
    }

    PROCESS {
        # Remove type accelerators for every exportable type.
        $ExportableType |
            Where-Object -FilterScript { Test-TypeAcceleratorRegistered -ExportableType $_ } |
                ForEach-Object -Process {
                    if ($PSCmdlet.ShouldProcess($_.FullName, $CmdletName)) {
                        $TypeAcceleratorsClass::Remove($_.FullName)
                    }
                }
    }

    <#
        .SYNOPSIS
        Remove exportable types as type accelerators.

        .DESCRIPTION
        `Remove-TypeAccelerator` removes exportable types as type accelerators from the current session.

        .PARAMETER ExportableType
        Specifies the exportable types to remove as type accelerators.

        .INPUTS
        System.Type[]  You can pipe types to `Remove-TypeAccelerator`.

        .OUTPUTS
        None.  `Remove-TypeAccelerator` does not generate any output.

        .EXAMPLE
        PS> [Vine] | Remove-TypeAccelerator

        This command removes the `[Vine]` type as a type accelerator from the current session.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        The type accelerator is not removed if it is not registered.

        The type accelerator is not removed if the `-WhatIf` common parameter is used.

        The type accelerator is not removed if the `-Confirm` common parameter is used and the user does not confirm the operation.

        .LINK
        about_Advanced_Function

        .LINK
        ForEach-Object

        .LINK
        Get-TypeAcceleratorClass

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Test-TypeAcceleratorRegistered

        .LINK
        Where-Object
    #>
}

<#
    Test-TypeAcceleratorRegistered
#>
function Test-TypeAcceleratorRegistered {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingExportableType')]
        [type[]]
        $ExportableType,

        [Parameter(Mandatory, ParameterSetName = 'UsingTypeName')]
        [ValidateNotNullOrEmpty()]
        [string]
        $TypeName
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $PSCmdlet.MyInvocation.MyCommand

        # Get the internal TypeAccelerators class to use its static methods.
        $TypeAcceleratorsClass = Get-TypeAcceleratorClass
    }

    PROCESS {
        # Check if the type accelerator is registered.
        $ExistingTypeAccelerators = $TypeAcceleratorsClass::Get

        $ExportableType | ForEach-Object -Process {
            if ($_.FullName -in $ExistingTypeAccelerators.Keys) {
                return $true
            }
        }

        return $false
    }

    <#
        .SYNOPSIS
        Test if type accelerators are registered.

        .DESCRIPTION
        `Test-TypeAcceleratorRegistered` tests if type accelerators are registered in the current session.

        .PARAMETER ExportableType
        Specifies the exportable types to test if they are registered.

        .PARAMETER TypeName
        Specifies the type full name to test if it is registered.

        .INPUTS
        System.Type[]  You can pipe types to `Test-TypeAcceleratorRegistered`.

        .OUTPUTS
        System.Boolean  `Test-TypeAcceleratorRegistered` returns `$true` if the type accelerator is registered; otherwise, `$false`.

        .EXAMPLE
        PS> [Vine] | Test-TypeAcceleratorRegistered

        This command tests if the `[Vine]` type accelerator is registered in the current session.

        .EXAMPLE
        PS> Test-TypeAcceleratorRegistered -TypeName 'Vine'

        This command tests if the `Vine` type accelerator is registered in the current session.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_Advanced_Function

        .LINK
        ForEach-Object

        .LINK
        Get-TypeAcceleratorClass

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}