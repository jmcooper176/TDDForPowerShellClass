<#
	.SYNOPSIS
	Commit message template for Git

	.DESCRIPTION
	`.gitmessage.ps1` is a PowerShell script that provides a template for git commit messages.  It is designed to be used with the `commit.template` configuration option in Git.  The script is designed to be used with the `git commit` command.

	Making git history clean, maintainable and easy to access ia very important.
	Please use the following guidelines to format all your commit messages:

	  <type> <id> (<scope>):  <title>
      <BLANK LINE>
      <body>
      <BLANK LINE>
      <footer>

    Re-establishing the context of a piece of code is wasteful.  We can’t avoid it
    completely, so our efforts should go to reducing it [as much] as possible.  Commit
    messages can do exactly that and as a result, a commit message shows whether a
    developer is a good collaborator.
      -- Peter Hutterer

    SEVEN RULES of great Git commit messages:

	1) Separate subject from body with a blank line
    2) Limit the subject line to 50 characters
    3) Capitalize the subject line
    4) Do not end the subject line with a period
    5) Use the imperative mood in the subject line
    6) Wrap the body at 72 characters
    7) Use the body to explain what and why vs. how

      -- https://chris.beams.io/posts/git-commit/

	.PARAMETER Type
	The type of change being made.  Allowed values are 'bug', 'epic', 'feature', 'issue', 'task', 'test case', and 'user story'.

	+ <type> describes the kind of change that this commit is providing.
	  Allowed types are:
	* bug (bug fix)
	* epic (container for features and user stories)
	* feature (referring to user story(s) impementing each feature)
	* issue (container for one or more bugs, technical debt, etc.)
	* test case (for Q & A applying to products for testing)
	* user story (define the applications, requirements, and elements that teams need to create)

	.PARAMETER SubType
	The subtype of the type of change being made.  Allowed values are 'chore', 'distraction', 'documentation', 'integration test', 'maintainance', 'refactor', 'style', 'technical debt', and 'validation'.  Applicable only to 'task' type.

	.PARAMETER Id
	The number or other identifier specifying the type instance to source control.  In Azure DevOps, for example, Id's after a '#' are treated specially and linked to this title.

	.PARAMETER Path
	The location of the source control.  This parameter is optional.

	.PARAMETER Scope
	The commit location.  Allowed values are 'local' and 'global'.  The default value is 'local'.

	.PARAMETER Title
	A description of 50 characters or less.  The title is in the following format: 
	* imperative, present tense: “change” not “changed” / “changes”
	* not Camel or Pascal Case
	* no dot (.) at the end

	.PARAMETER Resolving
	Indicates that the commit is resolving an issue.

	.PARAMETER Closing
	Indicates that the commit is closing an issue.

	.PARAMETER All
	Indicates that all changes should be committed.

	.INPUTS
	None.  You cannot pipe objects to `.gitmessage.ps1`.

	.OUTPUTS
	None.  `.gitmessage.ps1` does not return any objects.

	.NOTES
	Copyright (c) 2024, U.S. Office of Personnel Management.  All Rights Reserved.

	NOTES on format: 
	- The HEADER is a single line of 50 characters maximum that contains a succinct description of the change. It contains a type, an optional scope, and a subject

    + <type> describes the kind of change that this commit is providing.
      Allowed types are:

      * bug (bug fix)
      * epic (container for features and user stories)
      * feature (referring to user story(s) impementing each feature)
      * issue (container for one or more bugs, technical debt, etc.)
      * test case (for Q & A applying to products for testing)
      * user story (define the applications, requirements, and
        elements that teams need to create)

      * The many guises of TASKS:
       - task (chore)
       - task (distraction)
       - task (documentation)
       - task ([integration|UI|unit]
         test (when adding additional
         test(s) or modifying tests)
       - task (maintainenance)
       - task (refactor) (logic stays constant in effect and
         application, but the syntax for how that logic executes
         changes
       - task (style) (formatting, punctuation, spelling, . . .)
       - task (technical debt)
       - task (validation)

    + #<id> number or other identifier specifying the type instance to
      source control.  NOTE:  In Azure DevOps, for example, Id's after a
      '#' are treated specially and linked to this title

    + <scope> can be anything specifying the
      commit location [local|
      source {path}|global]

    + <title> a description of 50 characters or less.  You can always modify
      the title later.  It is in the following format:

      * imperative, present tense:
        “change” not “changed” / “changes”
      * not Camel or Pascal Case
      * no dot (.) at the end

	.LINK
	about_Functions_Advanced_Parameters
#>


[CmdletBinding()]
param (
	[Parameter(Mandatory)]
	[ValidateSet('bug', 'epic', 'feature', 'issue', 'task', 'test case', 'user story')]
	[string]
	$Type,

	[ValidateSet('chore', 'distraction', 'documentation', 'integration test', 'maintainance', 'refactor', 'style', 'technical debt', 'validation')]
	[string]
	$SubType,

	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string]
	$Id,

	[ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
	[string]
	$Path,

	[ValidateSet('local', 'global')]
	[string]
	$Scope = 'local',

	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string]
	$Title,

	[ValidateSet('Breaking', 'Closing', 'Resolving')]
	[string]
	$Mode = 'Resolving',

	[switch]
	$All
)

<#
	Script
#>
if ($MyInvocation.InvocationName -ne '.') {
	Set-StrictMode -Version 3.0
	Set-Variable -Name ScriptName -Option ReadOnly -Value $MyInvocation.MyCommand.Name

	Import-Module -Name '.\GitModule.psd1'

	if ($PSBoundParameters.ContainsKey('Path')) {
		$header = Write-Header -Type $Type -Id $Id -Path $Path -Scope $Scope -Title $Title
	}
	else {
		$header = Write-Header -Type $Type -Id $Id -Scope $Scope -Title $Title
	}

	$body   = Write-Body
	$footer = Write-Footer -Type $Type -Id $Id -Mode $Mode

	$header, [Environment]::NewLine, $body, [Environment]::NewLine, $footer |
		Tee-Object -Variable Message |
			Out-String |
				Write-Verbose

	$Message | Invoke-Git -Command 'commit' -All: $All.IsPresent
}