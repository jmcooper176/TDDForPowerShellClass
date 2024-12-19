<#
    Write-StdOut
#>
function Write-StdOut {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingMessage')]
        [AllowNull()]
        [AllowEmptyString()]
        [AllowEmptyCollection()]
        [string[]]
        $Message,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingFormatString')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Format,

        [Parameter(ParameterSetName = 'UsingFormatString')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [object[]]
        $ArgumentList,

        [switch]
        $NoNewLine
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        if ($NoNewLine.IsPresent) {
            if ($PSCmdlet.ParameterSetName -eq 'UsingFormatString') {
                [Console]::Out::Write($Format, $ArgumentList)
            }
            else {
                $Message | ForEach-Object -Process { [Console]::Out::Write($_) }
            }
        }
        else {
            if ($PSCmdlet.ParameterSetName -eq 'UsingFormatString') {
                [Console]::Out::WriteLine($Format, $ArgumentList)
            }
            else {
                $Message | ForEach-Object -Process { [Console]::Out::WriteLine($_) }
            }
        }
    }
}

<#
    Write-StdErr
#>
function Write-StdErr {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingMessage')]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Message,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'UsingFormatString')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Format,

        [Parameter(ParameterSetName = 'UsingFormatString')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [object[]]
        $ArgumentList,

        [switch]
        $NoNewLine
    )

    BEGIN {
        Set-StrictMode -Version 3.0
        Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name
    }

    PROCESS {
        if ($NoNewLine.IsPresent) {
            if ($PSCmdlet.ParameterSetName -eq 'UsingFormatString') {
                [Console]::Error::Write($Format, $ArgumentList)
            }
            else {
                [Console]::Error::Write($Message)
            }
        }
        else {
            if ($PSCmdlet.ParameterSetName -eq 'UsingFormatString') {
                [Console]::Error::WriteLine($Format, $ArgumentList)
            }
            else {
                [Console]::Error::WriteLine($Message)
            }
        }
    }
}