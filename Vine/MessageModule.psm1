#requires -Version 7.2

<#
    Add-SeparatorIfNotNullOrEmpty
#>
function Add-SeparatorIfNotNullOrEmpty {
    [CmdletBinding()]
    [OutputType([stringbuilder])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [stringbuilder]
        $Buffer,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : '
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        if (($null -eq $Buffer) -or ($Buffer.Length -le 0)) {
            $Buffer | Write-Output
        }
        else {
            $Buffer.Append($Separator) | Write-Output
        }
    }

    <#
        .SYNOPSIS
        Adds a separator to a string builder if the string builder is not null or empty.

        .DESCRIPTION
        The `Add-SeparatorIfNotNullOrEmpty` function adds a separator to a string builder if the string builder is not null or empty.

        .PARAMETER Buffer
        The string builder to which to add the separator.

        .PARAMETER Separator
        The separator to add to the string builder.

        .INPUTS
        [stringbuilder]  You can pipe a string builder to `Add-SeparatorIfNotNullOrEmpty`.

        .OUTPUTS
        [stringbuilder]  The function returns a string builder to the PowerShell pipeline.

        .EXAMPLE
        PS> $buffer = [System.Text.StringBuilder]::new()
        PS> $buffer.Append('Hello, World!') | Add-SeparatorIfNotNullOrEmpty -Separator ' : ' | Write-Output

        Hello, World!: 
        
        Adds a separator to the string builder 'Hello, World!'.

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

        .LINK
        Write-Output
    #>
}

<#
    Format-Error
#>
function Format-Error {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [errorrecord[]]
        $ErrorRecord,

        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : ',

        [switch]
        $AsLocal,

        [switch]
        $Timestamp,

        [switch]
        $UseCaller
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Category = $ErrorRecord.CategoryInfo.Category
        $ErrorId = $ErrorRecord.FullyQualifiedErrorId
        $ExceptionName = $ErrorRecord.Exception.GetType().FullName
        $HResult = $ErrorRecord.Exception.HResult

        $hr = ('0x{0:X8}|{0}' -f $HResult)

        $formatMessageSplat = @{
            Content        = $ErrorRecord.Exception.Message
            InvocationInfo = $InvocationInfo
            Metadata       = @($ErrorId, $ExceptionName, $Category, $hr)
            Separator      = $Separator
            AsLocal        = $AsLocal.IsPresent
            Timestamp      = $Timestamp.IsPresent
            UseCaller      = $UseCaller.IsPresent
        }

        Format-Message @formatMessageSplat | Write-Output
    }

    <#
        .SYNOPSIS
        Formats an error record as a string message.

        .DESCRIPTION
        The `Format-Error` function formats an error record as a string message.

        .PARAMETER ErrorRecord
        The error record to format.

        .PARAMETER InvocationInfo
        The invocation information for the error record.

        .PARAMETER Separator
        The separator to use between the message and the metadata.

        .PARAMETER AsLocal
        Indicates that the timestamp should be formatted as a local time.

        .PARAMETER Timestamp
        Indicates that a timestamp should be included in the message.

        .PARAMETER UseCaller
        Indicates that the caller should be used as the origin of the message.  The default is to use the script path.

        .INPUTS
        [ErrorRecord]  You can pipe an error record to `Format-Error`.

        .OUTPUTS
        [string]  The function returns a string message to the PowerShell pipeline.

        .EXAMPLE
        PS> Get-ChildItem -Path 'C:\Windows\Temp\DoesNotExist'
        PS> $Error | Format-Error -InvocationInfo $MyInvocation | Write-Error -ErrorAction Continue

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

        .LINK
        Write-Output
    #>
}

<#
    Format-ErrorId
#>
function Format-ErrorId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Caller,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Cause,

        [Parameter(Mandatory)]
        [ValidateRange(1, 2147483647)]
        [int]
        $Line
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    ('{0}-{1}-{2}' -f $Caller, $Cause, $Line) | Write-Output

    <#
        .SYNOPSIS
        Formats an error identifier.

        .DESCRIPTION
        The `Format-ErrorId` function formats an error identifier.

        .PARAMETER Caller
        The name of the caller.

        .PARAMETER Cause
        The cause of the error.

        .PARAMETER Line
        The line number where the error occurred.

        .INPUTS
        None.  You cannot pipe input to `Format-ErrorId`.

        .OUTPUTS
        [string]  The function `Format-ErrorId` returns a string message to the PowerShell pipeline.

        .EXAMPLE
        PS> Format-ErrorId -Caller 'Get-ChildItem' -Cause 'ObjectNotFound' -Line 42

        Get-ChildItem-ObjectNotFound-42

        Creates an error identifier for the `Get-ChildItem` cmdlet when an object is not found on line 42.

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

        .LINK
        Write-Output
    #>
}

<#
    Format-Exception
#>
function Format-Exception {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('NotSpecified', 'OpenError', 'CloseError', 'DeviceError', 'DeadlockDetected',
            'InvalidArgument', 'InvalidData', 'InvalidOperation', 'InvalidResult', 'MetadataError',
            'NotImplemented', 'NotInstalled', 'ObjectNotFound', 'OperationStopped', 'OperationTimeout',
            'SyntaxError', 'ParserError', 'PermissionDenied', 'ResourceBusy', 'ResourceExists',
            'ResourceUnavailable', 'ReadError', 'WriteError', 'FromStdErr', 'SecurityError',
            'ProtocolError', 'ConnectionError', 'AuthenticationError', 'LimitExceeded', 'QuotaExceeded',
            'NotEnabled')]
        [ErrorCategory]
        $Category,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [exception]
        $Exception,

        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : ',

        [Parameter(Mandatory)]
        [AllowNull()]
        [object]
        $TargetObject,

        [ValidateNotNullOrEmpty()]
        [string]
        $TargetName,

        [switch]
        $AsLocal,

        [switch]
        $Timestamp,

        [switch]
        $UseCaller
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $Caller = $InvocationInfo.MyCommand.Name
        $Line = $InvocationInfo.ScriptLineNumber
        $ExceptionName = $Exception.GetType().Name

        $formatErrorSplat = @{
            InvocationInfo = $InvocationInfo
            Separator      = $Separator
            AsLocal        = $AsLocal.IsPresent
            Timestamp      = $Timestamp.IsPresent
            UseCaller      = $UseCaller.IsPresent
        }

        if (-not ($PSBoundParameters.ContainsKey('TargetName'))) {
            $TargetName = $Caller
            $targetType = $InvocationInfo.MyCommand.CommandType.ToString()
        }
        else {
            $targetType = $TargetObject.GetType().Name
        }

        $newErrorRecordSplat = @{
            Category           = $Category
            CategoryReason     = "An exception of type '$($ExceptionName)' was thrown by source '$($Caller)'"
            CategoryTargetName = $TargetName
            CategoryTargetType = $targetType
            ErrorId            = (Format-ErrorId -Caller $Caller -Cause $ExceptionName -Line $Line)
            Exception          = $Exception
            RecommendedAction  = 'Review the exception message and correct the issue.'
            TargetObject       = $TargetObject
            WhatIf             = $false
        }

        New-ErrorRecord @newErrorRecordSplat | Format-Error @formatErrorSplat
    }

    <#
        .SYNOPSIS
        Formats an exception as a string message.

        .DESCRIPTION
        The `Format-Exception` function formats an exception as a string message.

        .PARAMETER Category
        The error category for the exception.

        .PARAMETER Exception
        The exception to format.

        .PARAMETER InvocationInfo
        The invocation information for the exception.

        .PARAMETER Separator
        The separator to use between the message and the metadata.

        .PARAMETER TargetObject
        The target object for the exception.

        .PARAMETER TargetName
        The name of the target object.

        .PARAMETER AsLocal
        Indicates that the timestamp should be formatted as a local time.

        .PARAMETER Timestamp

        Indicates that a timestamp should be included in the message.

        .PARAMETER UseCaller
        Indicates that the caller should be used as the origin of the message.  The default is to use the script path.

        .INPUTS
        [exception]  You can pipe an exception to `Format-Exception`.

        .OUTPUTS
        [string]  The function returns a string message to the PowerShell pipeline.

        .EXAMPLE
        PS> try {
        >>     Get-ChildItem -Path 'C:\Windows\Temp\DoesNotExist'
        >> }
        >> catch {
        >>     $_.Exception | Format-Exception -Category ObjectNotFound -InvocationInfo $MyInvocation | Write-Error -ErrorAction Continue
        >> }

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Format-Error

        .LINK
        New-ErrorRecord

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable
    #>
}

<#
    Format-Message
#>
function Format-Message {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]
        $Content,

        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [Alias('Tag')]
        [string[]]
        $Metadata,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : ',

        [switch]
        $AsLocal,

        [switch]
        $Timestamp,

        [switch]
        $UseCaller
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

        $buffer = [StringBuilder]::new()
    }

    PROCESS {
        $formatOriginSplat = @{
            InvocationInfo = $InvocationInfo
            Separator      = $Separator
            AsLocal        = $AsLocal.IsPresent
            Timestamp      = $Timestamp.IsPresent
            UseCaller      = $UseCaller.IsPresent
        }

        $origin = Format-Origin @formatOriginSplat
        $buffer.Append($origin) | Add-SeparatorIfNotNullOrEmpty -Separator $Separator

        if ($PSBoundParameters.ContainsKey('Metadata')) {
            $metaString = Format-Metadata -Metadata $Metadata
            $buffer.Append($metaString) | Add-SeparatorIfNotNullOrEmpty -Separator $Separator
        }

        $Content | ForEach-Object -Process {
            ('{0}{1}' -f $buffer.ToString(), $_) | Write-Output
        }
    }

    END {
        $buffer.Clear()
    }

    <#
        .SYNOPSIS
        Formats a message as a string message loosely following the Microsoft compiler message format.

        .DESCRIPTION
        The `Format-Message` function formats a message as a string message loosely following the Microsoft compiler message format.

        .PARAMETER Content
        The content of the message.

        .PARAMETER InvocationInfo
        The invocation information for the message.

        .PARAMETER Metadata
        The metadata for the message.

        .PARAMETER Separator
        The separator to use between the message and the metadata.

        .PARAMETER AsLocal
        Indicates that the timestamp should be formatted as a local time.

        .PARAMETER Timestamp
        Indicates that a timestamp should be included in the message.

        .PARAMETER UseCaller
        Indicates that the caller should be used as the origin of the message.  The default is to use the script path.

        .INPUTS
        [string]  You can pipe a string message to `Format-Message`.

        .OUTPUTS
        [string]  The function returns a string message to the PowerShell pipeline.

        .EXAMPLE
        PS> Format-Message -Content 'Hello, World!' -InvocationInfo $MyInvocation | Write-Output

        C: \Users\John\Documents\HelloWorld.ps1(42,1): Hello, World!
        
        Formats a message with the content 'Hello, World!' at line 42, column 1 in the script 'HelloWorld.ps1'.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        ForEach-Object

        .LINK
        Format-Metadata

        .LINK
        Format-Origin

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    Format-Metadata
#>
function Format-Metadata {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]
        $Metadata,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' '
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    $Metadata -join $Separator | Write-Output
}

<#
    Format-Origin
#>
function Format-Origin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : ',

        [switch]
        $AsLocal,

        [switch]
        $Timestamp,

        [switch]
        $UseCaller
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

    $Line = $InvocationINfo.ScriptLineNumber
    $Column = $InvocationInfo.OffsetInLine
    $Path = $InvocationInfo.PSCommandPath
    $Caller = $InvocationInfo.MyCommand.Name

    if ($Timestamp.IsPresent -and $AsLocal.IsPresent) {
        $time = Get-Date -Format 's'
    }
    elseif ($Timestamp.IsPresent) {
        $time = Get-Date -AsUTC -Format 's'
    }

    if ($Timestamp.IsPresent -and $UseCaller.IsPresent) {
        ('[{0}]{1}({2},{3})' -f $time, $Caller, $Line, $Column) | Write-Output
    }
    elseif ($UseCaller.IsPresent) {
        ('{0}({1},{2})' -f $Caller, $Line, $Column) | Write-Output
    }
    elseif ($Timestamp.IsPresent) {
        ('[{0}]{1}({2},{3})' -f $time, $Path, $Line, $Column) | Write-Output
    }
    else {
        ('{0}({1},{2})' -f $Path, $Line, $Column) | Write-Output
    }

    <#
        .SYNOPSIS
        Formats the origin of a message.

        .DESCRIPTION
        The `Format-Origin` function formats the origin of a message.

        .PARAMETER InvocationInfo
        The invocation information for the origin.

        .PARAMETER Separator
        The separator to use between the message and the metadata.

        .PARAMETER AsLocal
        Indicates that the timestamp should be formatted as a local time.

        .PARAMETER Timestamp
        Indicates that a timestamp should be included in the message.

        .PARAMETER UseCaller
        Indicates that the caller should be used as the origin of the message.  The default is to use the script path.

        .INPUTS
        None.  You cannot pipe input to `Format-Origin`.

        .OUTPUTS
        [string]  The function returns a string message to the PowerShell pipeline.

        .EXAMPLE
        PS> Format-Origin -InvocationInfo $MyInvocation | Write-Output

        C: \Users\John\Documents\HelloWorld.ps1(42,1)

        Formats the origin of a message at line 42, column 1 in the script 'HelloWorld.ps1'.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Get-Date

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    New-ErrorRecord
#>
function New-ErrorRecord {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([ErrorRecord])]
    param (
        [Parameter(Mandatory)]
        [exception]
        $Exception,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ErrorId,

        [Parameter(Mandatory)]
        [ValidateSet('NotSpecified', 'OpenError', 'CloseError', 'DeviceError', 'DeadlockDetected',
            'InvalidArgument', 'InvalidData', 'InvalidOperation', 'InvalidResult', 'MetadataError',
            'NotImplemented', 'NotInstalled', 'ObjectNotFound', 'OperationStopped', 'OperationTimeout',
            'SyntaxError', 'ParserError', 'PermissionDenied', 'ResourceBusy', 'ResourceExists',
            'ResourceUnavailable', 'ReadError', 'WriteError', 'FromStdErr', 'SecurityError',
            'ProtocolError', 'ConnectionError', 'AuthenticationError', 'LimitExceeded', 'QuotaExceeded',
            'NotEnabled')]
        [ErrorCategory]
        $Category,

        [Parameter(Mandatory)]
        [AllowNull()]
        [object]
        $TargetObject,

        [string]
        $CategoryActivity,

        [string]
        $CategoryReason,

        [string]
        $CategoryTargetName,

        [string]
        $CategoryTargetType = $TargetObject.GetType().Name,

        [string]
        $RecommendedAction
    )

    Set-StrictMode -Version 3.0
    Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name -WhatIf:$false

    $newObjectSplat = @{
        TypeName     = 'System.Management.Automation.ErrorRecord'
        ArgumentList = @($Exception, $ErrorId, $Category, $TargetObject)
    }

    $errorRecord = New-Object @newObjectSplat

    if ($PSBoundParameters.ContainsKey('CategoryActivity')) {
        $errorRecord.CategoryInfo.Activity = $CategoryActivity
    }

    if ($PSBoundParameters.ContainsKey('CategoryReason')) {
        $errorRecord.CategoryInfo.Reason = $CategoryReason
    }

    if ($PSBoundParameters.ContainsKey('CategoryTargetName')) {
        $errorRecord.CategoryInfo.TargetName = $CategoryTargetName
    }

    if ($null -ne $TargetObject) {
        $errorRecord.CategoryInfo.TargetType = $CategoryTargetType
    }
    else {
        $errorRecord.CategoryInfo.TargetType = 'System.Object'
    }

    if ($PSBoundParameters.ContainsKey('RecommendedAction')) {
        $errorRecord.CategoryInfo.RecommendedAction = $RecommendedAction
    }

    if ($PSCmdlet.ShouldProcess($ErrorId, $CmdletName)) {
        $errorRecord | Write-Output
    }
    else {
        $errorRecord | Format-List
    }

    <#
        .SYNOPSIS
        Creates a new error record.

        .DESCRIPTION
        The `New-ErrorRecord` function creates a new error record.  Optionally, you can specify the error category, target object, category activity, category reason, category target name, and recommended action.

        .PARAMETER Exception
        The exception to include in the error record.

        .PARAMETER ErrorId
        The error identifier for the error record.

        .PARAMETER Category
        The error category for the error record.

        .PARAMETER TargetObject
        The target object for the error record.

        .PARAMETER CategoryActivity
        The category activity for the error record.

        .PARAMETER CategoryReason
        The category reason for the error record.

        .PARAMETER CategoryTargetName
        The category target name for the error record.

        .PARAMETER CategoryTargetType
        The category target type for the error record.

        .PARAMETER RecommendedAction
        The recommended action for the error record.

        .INPUTS
        None.  You cannot pipe input to `New-ErrorRecord`.

        .OUTPUTS
        [ErrorRecord]  The function returns an error record to the PowerShell pipeline.

        .EXAMPLE
        PS> New-ErrorRecord -Exception $Error[0].Exception -ErrorId 'Get-ChildItem-ObjectNotFound-42' -Category ObjectNotFound -TargetObject $Error[0].TargetObject -CategoryActivity 'OpenError' -CategoryReason 'An exception of type 'System.Management.Automation.ItemNotFoundException' was thrown by source 'Get-ChildItem'' -CategoryTargetName 'Get-ChildItem' -CategoryTargetType 'System.Management.Automation.CmdletInvocationException' -RecommendedAction 'Review the exception message and correct the issue.'

        Creates an error record for the `Get-ChildItem` cmdlet when an object is not found on line 42.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Format-List

        .LINK
        New-Object

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Output
    #>
}

<#
    Write-DebugIf
#>
function Write-DebugIf {
    [CmdletBinding(DefaultParameterSetName = 'UsingCondition')]
    param (
        [Parameter(Mandatory, ParameterSetName = 'UsingCondition')]
        [bool]
        $Condition,

        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [Parameter(Mandatory, ValueFromPioeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message,

        [Parameter(ParameterSetName = 'UsingScriptBlock')]
        [scriptblock]
        $ScriptBlock,

        [ValidateNotNullOrEmpty()]
        [string]
        $Separator = ' : ',

        [switch]
        $AsLocal,

        [switch]
        $Timestamp,

        [switch]
        $UseCaller
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        if ($PSCmdlet.ParameterSetName -eq 'UsingScriptBlock') {
            $Condition = & $ScriptBlock
        }

        if ($Condition) {
            $origin = Format-Origin -InvocationInfo $InvocationInfo -Separator $Separator
            Write-Debug -Message $Message
        }
    }

    <#
        .SYNOPSIS
        Writes a debug message if a condition is met.

        .DESCRIPTION
        The `Write-DebugIf` function writes a debug message if a condition is met.

        .PARAMETER Condition
        The condition to evaluate.

        .PARAMETER Message
        The message to write.

        .PARAMETER ScriptBlock
        The script block to evaluate.  If the script block returns `$true`, the message is written.

        .INPUTS
        None.  You cannot pipe input to `Write-DebugIf`.

        .OUTPUTS
        None.  The function does not return any output.

        .EXAMPLE
        PS> Write-DebugIf -Condition $true -Message 'This is a debug message.'

        Writes a debug message to the PowerShell host.

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

        .LINK
        Write-Debug

        .LINK
        Write-Output
    #>
}

<#
    Write-Fatal
#>
function Write-Fatal {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [errorrecord]
        $ErrorRecord,

        [Parameter(Mandatory)]
        [invocationinfo]
        $InvocationInfo,

        [switch]
        $ThrowHard
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        $ErrorRecord | Format-Error -InvocationInfo $InvocationInfo | Write-Error -ErrorAction Continue

        if ($ThrowHard.IsPresent) {
            $target = "Throwing a hard terminating error for error record '$($ErrorRecord.FullyQualifedErrorId)'."
        }
        else {
            $target = "Throwing a soft terminating error for error record '$($ErrorRecord.FullyQualifedErrorId)'."
        }

        if ($PSCmdlet.ShouldProcess($target, $CmdletName)) {
            if ($ThrowHard.IsPresent) {
                throw $ErrorRecord.Exception
            }
            else {
                $PSCmdlet.ThrowTerminatingError($ErrorRecord)
            }
        }
    }

    <#
        .SYNOPSIS
        Writes a fatal error message to the PowerShell host and throws as soft or hard terminating error.

        .DESCRIPTION
        The `Write-Fatal` function writes a fatal error message to the PowerShell host and throws as soft or hard terminating error.

        .PARAMETER ErrorRecord
        The error record to write.

        .PARAMETER InvocationInfo
        The invocation information for the the message origin.

        .PARAMETER ThrowHard
        Indicates that a hard terminating error should be thrown.  The default is to throw a soft terminating error.

        .INPUTS
        [ErrorRecord]  You can pipe an error record to `Write-Fatal`.

        .OUTPUTS
        None.  The function does not return any output.

        .EXAMPLE
        PS> $Error[0] | Write-Fatal -InvocationInfo $MyInvocation

        Writes a fatal error message to the PowerShell host and throws a soft terminating error.

        .NOTES
        Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

        .LINK
        about_CommonParameters

        .LINK
        about_Functions_Advanced

        .LINK
        Format-Error

        .LINK
        Set-StrictMode

        .LINK
        Set-Variable

        .LINK
        Write-Error
    #>
}
