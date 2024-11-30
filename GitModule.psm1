<#
	Invoke-GitCommit
#>
function Invoke-GitCommit {
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory, ValueFromPipeline)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Message,

		[switch]
		$All
	)

	BEGIN {
		Set-StrictMode -Version 3.0
		Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

		if ($All.IsPresent) {
			$option = '--all'
		}
		else {
			$option = '--interactive'
		}

		if ($PSBoundParameters.ContainsKey('Verbose') -or $VerbosePreference -eq 'Continue') {
			$option += ' '
			$option += '--verbose'
		}

		if ($WarningPreference -eq 'SilentlyContinue') {
			$option += ' '
			$option = '--quiet'
		}

		if ($PSBoundParameters.ContainsKey('WhatIf') -and $WhatIfPreference) {
			$option += ' '
			$option += '--dry-run'
		}
	}

	PROCESS {
		$CommandLine = ('git commit "{0}" {1}' -f $Message, $option)

		if ($PSCmdlet.ShouldProcess($CommandLine, $CmdletName)) {
			& $CommandLine

			if ($LASTEXITCODE -ne 0) {
				Write-Warning -Message "git commit did not appear to exit successfully:  $LASTEXITCODE"
			}
			else {
				Write-Verbose -Message "git commit appears to have exited successfully"
			}
		}
	}
}

<#
	Write-Body
#>
function Write-Body {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Why,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$What,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$How
	)

	$Why | Write-Output
	$What | Write-Output
	$How | Write-Output

	<#
		.SYNOPSIS
		Format body for git commit message

		.DESCRIPTION
		`Write-Body` is a function that formats the body of a git commit message.

		.PARAMETER Why
		The motivation for the change answering the question 'Why?'

		.PARAMETER What
		Contrast 'why' with previous behavior answering the question 'What?'

		.PARAMETER How
		Optionally describe technical aspects for the change answering the question 'How?'

		.INPUTS
		None.  `Write-Body` does not accept pipeline input.

		.OUTPUTS
		System.String.  `Write-Body` returns a string.

		.EXAMPLE
		PS> Write-Body -Why 'Fix a bug' -What 'Bug was causing a crash' -How 'Fixed a bug in the code'

		Fix a bug
		Bug was causing a crash
		Fixed a bug in the code

		.NOTES
		Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.

		The BODY should include, using phrasing in the imperative present tense:
		* the motivation for the change answering the question 'Why?'
		* contrast 'why' with previous behavior answering the question 'What?'
		* optionally describe technical aspects for the change answering the question 'How?'

		.LINK
		about_Functions_Advanced
	#>
}

<#
	Write-Footer
#>
function Write-Footer {
	[CmdletBinding()]
	param (
		[ValidateSet('bug', 'epic', 'feature', 'issue', 'task', 'test case', 'user story')]
		[string]
		$Type,

		[ValidateNotNullOrEmpty()]
		[string]
		$Id,

		[ValidateSet('Breaking', 'Closing', 'Resolving')]
		[string]
		$Mode,

		[TimeSpan]
		$CapitalizedTime
	)

	Set-StrictMode -Version 3.0
	Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

	if ($Closing.IsPresent -and $Resolving.IsPresent) {
		Write-Warning -Message "Cannot both Close a <type> #<id> and Resolve it"
		return
	}

	if ($PSBoundParameters.ContainsKey('Type') -and $PSBoundParameters.ContainsKey('Id')) {
		if ($Mode -eq 'Breaking') {
			'Breaking' | Write-Output
		}

		if ($Mode -eq 'Closing') {
			'Closing' | Write-Output
		}

		if ($Mode -eq 'Resolving') {
			'Closing' | Write-Output
		}

		('- {0} #{1}' -f $Type, $Id) | Write-Output
	}

	if ($PSBoundParameters.ContainsKey('CapitalizedTime')) {
		Set-Variable -Name QuarterHour -Option Constant -Value (New-TimeSpan -Minutes 15 | Select-Object -ExpandProperty Ticks)

		$CapitalizedRounded = [Math]::Round($CapitalizedTime.Ticks / $QuarterHour) * $QuarterHour
		$CapitalizedTime    = [TimeSpan]$CapitalizedRounded
		'- Capitalized Time' | Write-Output
		('{0} hour(s)' -f $CapitalizedTime.TotalHours) | Write-Output
	}

	<#
		.SYNOPSIS
		Format footer for git commit message

		.DESCRIPTION
		`Write-Footer` is a function that formats the footer of a git commit message.

		.PARAMETER Type
		The type of the commit message.

		.PARAMETER Id
		The id of the commit message.

		.PARAMETER Mode
		The mode of the commit message.  If present, one of `Breaking`, `Closing`, or `Resolving`.

		.INPUTS
		None.  `Write-Footer` does not accept pipeline input.

		.OUTPUTS
		System.String.  `Write-Footer` returns a string.

		.EXAMPLE
		PS> Write-Footer

		.EXAMPLE
		PS> Write-Footer -CapitalizedTime 0.51

		Capitalized Time
		- 0.5 hour(s)

		.EXAMPLE
		PS> Write-Footer -Type 'bug' -Id '1245' -Mode 'Breaking'

		Breaking
		- bug #1245

		.EXAMPLE
		PS> Write-Footer -Type 'bug' -Id '1234' -Mode 'Closing'

		Closing
		- bug #1234

		.EXAMPLE
		PS> Write-Footer -Type 'bug' -Id '1234' -Mode 'Resolving' -CapitalizedTime '0.25'

		Resolving
		- bug #1234
		- Capitalized Time
		0.25 hour(s)

		.NOTES
		The FOOTER should contain: 
		* Breaking Changes made by this commit
		* issues that this commit Resolves or Closes
		* optionally, Capitalized time in decimal hours for this commit greater than or equal to 0.25 hours or more

		.LINK
		about_Functions_Advanced
	#>
}

<#
	Write-Header
#>
function Write-Header {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[ValidateSet('bug', 'epic', 'feature', 'issue', 'task', 'test case', 'user story')]
		[string]
		$Type,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Id,

		[ValidateSet('local', 'global')]
		[string]
		$Scope = 'local',

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Title
	)

	Set-StrictMode -Version 3.0
	Set-Variable -Name CmdletName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

	if ($Scope -eq 'local') {
		$value = ('{0} #{1} (local):  {2}' -f $Type, $Id, $Title)
	}
	elseif ($Scope -eq 'global') {
		$value = ('{0} #{1} (global):  {2}' -f $Type, $Id, $Title)
	}
	else {
		$value = ('{0} #{1}:  {2}' -f $Type, $Id, $Title)
	}

	if ($value.Length -gt 50) {
		Write-Warning -Message "$($CmdletName) : Header is longer than 50 characters.  Truncating to 50 characters."
		$value.Substring(0, 50) | Write-Output
	}
	else {
		$value | Write-Output
	}

	<#
		.SYNOPSIS
		Format header for git commit message

		.DESCRIPTION
		`Write-Header` is a function that formats the header of a git commit message.

		.PARAMETER Type
		The type of the commit message.

		.PARAMETER Id
		The id of the commit message.

		.PARAMETER Scope
		The scope of the commit message.  If present, one of `local` or `global`.

		.PARAMETER Title
		The title of the commit message.

		.INPUTS
		None.  `Write-Header` does not accept pipeline input.

		.OUTPUTS
		System.String.  `Write-Header` returns a string.

		.EXAMPLE
		PS> Write-Header -Type 'bug' -Id '1234' -Scope 'local' -Title 'Fixing a bug'

		bug #1234 (local): Fixing a bug
		
		.EXAMPLE
		PS> Write-Header -Type 'epic' -Id '1234' -Scope 'global' -Title 'Creating an epic'

		epic #1234 (global): Creating an epic

		.EXAMPLE
		PS> Write-Header -Type 'feature' -Id '1234' -Title 'Adding a feature'

		feature #1234: Adding a feature

		.EXAMPLE
		PS> Write-Header -Type 'issue' -Id '1234' -Title 'Resolving an issue'

		issue #1234: Resolving an issue

		.EXAMPLE
		PS> Write-Header -Type 'task' -Id '1234' -Scope 'local' -Title 'Completing a task'

		task #1234 (local): Completing a task

		.EXAMPLE
		PS> Write-Header -Type 'test case' -Id '1234' -Title 'Testing a test case'

		test case #1234: Testing a test case

		.EXAMPLE
		PS> Write-Header -Type 'user story' -Id '1234' -Title 'Writing a user story'

		user story #1234: Writing a user story

		.NOTES
		Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.
		The HEADER should contain: 
		* the type of the commit message
		* the id of the commit message
		* optionally, the scope of the commit message
		* the title of the commit message

		Use one of these as a template:
		
		bug #id (local | global):  title
		epic #id (local | global):  title
		feature #id (local | global):  title
		issue #id (local | global):  title
		task (by type) #id (local | global):  title
		test case #id (local | global):  title
		user story #id (local | global):  title

		.LINK
		about_Functions_Advanced
	#>
}
