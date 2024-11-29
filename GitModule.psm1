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

	[switch]
	$Resolving,

	[switch]
	$Closing,

	[switch]
	$All
)

function Invoke-Git {
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory)]
		[ValidateSet('add', 'commit', 'pull', 'push', 'status')]
		[string]
		$Command,

		[Parameter(Mandatory, ValueFromPipeline)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Message,

		[switch]
		$All
	)

	BEGIN {
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
	}

	PROCESS {
		$CommandLine = ('git {0} "{1}" {1}' -f $Command, $Message, $option)

		if ($PSCmdlet.ShouldProcess($CommandLine, $Command)) {
			& $CommandLine

			if ($LASTEXITCODE -ne 0) {
				Write-Warning -Message "git $Command did not appear to exit successfully:  $LASTEXITCODE"
			}
			else {
				Write-Verbose -Message "git $Command appears to have exited successfully"
			}
		}
	}
}

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

		[ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
		[string]
		$Path,

		[ValidateSet('local', 'global')]
		[string]
		$Scope = 'local',

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Title
	)

	# HEADER (use one of these templates)
	# --------------------------------------------------------
	# bug #id (local source {path} global):  title
	# epic #id (local source {path} global):  title
	# feature #id (local source {path} global):  title
	# issue #id (local source {path} global):  title
	# task (by type) #id (local source {path} global):  title
	# test case #id (local source {path} global):  title
	# user story #id (local source {path} global):  title

	if ($Scope -eq 'local' -and $PSBoundParameters.ContainsKey('Path')) {
		$value = ('{0} #{1} (local source {2}): {3}' -f $Type, $Id, $Path, $Title)
	}
	elseif ($Scope -eq 'global') {
		$value = ('{0} #{1} (global): {2}' -f $Type, $Id, $Title)
	}
	else {
		$value = ('{0} #{1}: {2}' -f $Type, $Id, $Title)
	}

	if ($value.Length -gt 50) {
		$value.Substring(0, 50) | Write-Output
	}
	else {
		$value | Write-Output
	}
}

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

	#  - The BODY should include, using phrasing in the imperative present
	#    tense (see above):
	#
	#		* the motivation for the change answering the question
	#         'Why?'
	#       * contrast 'why' with previous behavior answering the
	#         question 'What?'
	#       * optionally describe technical aspects for the change
	#		  answering the question 'How?'

	$Why | Write-Output
	$What | Write-Output
	$How | Write-Output
}

function Write-Footer {
	[CmdletBinding()]
	param (
		[ValidateSet('bug', 'epic', 'feature', 'issue', 'task', 'test case', 'user story')]
		[string]
		$Type,

		[ValidateNotNullOrEmpty()]
		[string]
		$Id,

		[switch]
		$Closing,

		[switch]
		$Resolving
	)

	#  - The FOOTER should contain:
	#
	#		* Breaking Changes made by this commit
	#       * issues that this commit Resolves or Closes
	#       * optionally, Capitalized time in decimal hours for this
	#         commit greater than or equal to 0.25 hours or more

	if ($Closing.IsPresent -and $Resolving.IsPresent) {
		Write-Warning -Message "Cannot both Close a <type> #<id> and Resolve it"
		return
	}

	if ($PSBoundParameters.ContainsKey('Type') -and $PSBoundParameters.ContainsKey('Id')) {
		if ($Closing.IsPresent) {
			'Closing' | Write-Output
		}

		if ($Resolving.IsPresent) {
			'Closing' | Write-Output
		}

		('- {0} #{1}' -f $Type, $Id) | Write-Output
	}
}

# Hello o/!
#
# We just wanted to let you know that we care a great deal about making
# our git history clean, maintainable and easy to access for all our
# developers and testers.  Commit messages are very important to us,
# which is why we have a strict commit message policy in place.  Please
# use the following guidelines to format all your commit messages:
#
#     <type> <id> (<scope>):  <title>
#     <BLANK LINE>
#     <body>
#     <BLANK LINE>
#     <footer>
#
#     Re-establishing the context of a piece of
#     code is wasteful.  We can’t avoid it
#     completely, so our efforts should go to
#     reducing it [as much] as possible.  Commit
#     messages can do exactly that and as a
#     result, a commit message shows whether a
#     developer is a good collaborator.
#                            -- Peter Hutterer
#
# SEVEN RULES of great Git commit messages:
#
#          1) Separate subject from body with a blank line
#          2) Limit the subject line to 50 characters
#          3) Capitalize the subject line
#          4) Do not end the subject line with a period
#          5) Use the imperative mood in the subject line
#          6) Wrap the body at 72 characters
#          7) Use the body to explain what and why vs. how
#
#                           -- https://chris.beams.io/posts/git-commit/
#
# NOTES on format:
#
#  - The HEADER is a single line of 50 characters maximum that contains
#    a succinct description of the change. It contains a type, an
#    optional scope, and a subject
#
#       + <type> describes the kind of change
#                that this commit is providing.
#                Allowed types are:
#
#             * bug (bug fix)
#             * epic (container for features and
#               user stories)
#             * feature (referring to user
#               story(s) impementing each feature)
#             * issue (container for one or more
#               bugs, technical debt, etc.)
#             * test case (for Q & A applying to
#               products for testing)
#             * user story (define the
#               applications, requirements, and
#               elements that teams need to
#               create)
#
#             The many guises of TASKS:
#
#                  * task (chore)
#                  * task (distraction)
#                  * task (documentation)
#                  * task ([integration|UI|unit]
#                    test (when adding additional
#                    test(s) or modifying tests)
#                  * task (maintainenance)
#                  * task (refactor) (logic stays
#                    constant in effect and
#                    application, but the syntax
#                    for how that logic executes
#                    changes
#                  * task (style) (formatting,
#                    punctuation, spelling, . . .)
#                  * task (technical debt)
#                  * task (validation)
#
#       + #<id> number or other identifier
#               specifying the type instance to
#               source control.  NOTE:  In Azure
#               DevOps, for example, Id's after a
#               '#' are treated specially and
#               linked to this title
#
#       + <scope> can be anything specifying the
#                 commit location [local|
#                 source {path}|global]
#
#       + <title> a description of 50 characters
#                 or less.  You can always modify
#                 the title later.  It is in the
#                 following format:
#
#             * imperative, present tense:
#               “change” not “changed” / “changes”
#             * not Camel or Pascal Case
#             * no dot (.) at the end

if ($PSBoundParameters.ContainsKey('Path')) {
	$header = Write-Header -Type $Type -Id $Id -Path $Path -Scope $Scope -Title $Title
}
else {
	$header = Write-Header -Type $Type -Id $Id -Scope $Scope -Title $Title
}

if ($Closing.IsPresent -and $Resolving.IsPresent) {
	Write-Warning -Message "Cannot both Close a <type> #<id> and Resolve it"
	return
}

$body = Write-Body
$footer = Write-Footer -Type $Type -Id $Id -Closing:$Closing.IsPresent -Resolving:$Resolving.IsPresent

$header, [Environment]::NewLine, $body, [Environment]::NewLine, $footer |
	Tee-Object -Variable Message |
		Out-String |
			Write-Verbose

$Message | Invoke-Git -Command 'commit' -All:$All.IsPresent
