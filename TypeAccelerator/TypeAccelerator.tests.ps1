BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\TypeAccelerator.psd1' -Resolve
    Import-Module $modulePath -Force -Verbose
    $HelperModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\HelperModule\HelperModule.psd1' -Resolve
    Import-Module $HelperModulePath -Force -Verbose

    $MethodList = @(
        'Add-TypeAccelerator',
        'Get-TypeAccelerator',
        'Get-TypeAcceleratorClass',
        'Register-TypeAccelerator',
        'Remove-TypeAccelerator',
        'Test-TypeAccelerator'
    )

    $RemoveThese = @(
        'type'
    )

    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $RemoveThese | Remove-Alias -Force -Verbose
    }

    $TestData = @(
        @{Accelerator = [Alias];                          FullName = 'System.Management.Automation.AliasAttribute';},
        @{Accelerator = [AllowEmptyCollection];           FullName = 'System.Management.Automation.AllowEmptyCollectionAttribute';},
        @{Accelerator = [AllowEmptyString];               FullName = 'System.Management.Automation.AllowEmptyStringAttribute';},
        @{Accelerator = [AllowNull];                      FullName = 'System.Management.Automation.AllowNullAttribute';},
        @{Accelerator = [ArgumentCompleter];              FullName = 'System.Management.Automation.ArgumentCompleterAttribute';},
    #   @{Accelerator = [ArgumentCompletions];            FullName = 'System.Management.Automation.ArgumentCompletionsAttribute';},
        @{Accelerator = [array];                          FullName = 'System.Array';},
        @{Accelerator = [bool];                           FullName = 'System.Boolean';},
        @{Accelerator = [byte];                           FullName = 'System.Byte';},
        @{Accelerator = [char];                           FullName = 'System.Char';},
        @{Accelerator = [CmdletBinding];                  FullName = 'System.Management.Automation.CmdletBindingAttribute';},
        @{Accelerator = [datetime];                       FullName = 'System.DateTime';},
        @{Accelerator = [decimal];                        FullName = 'System.Decimal';},
        @{Accelerator = [double];                         FullName = 'System.Double';},
        @{Accelerator = [DscResource];                    FullName = 'System.Management.Automation.DscResourceAttribute';},
    #   @{Accelerator = [ExperimentAction];               FullName = 'System.Management.Automation.ExperimentAction';},
    #   @{Accelerator = [Experimental];                   FullName = 'System.Management.Automation.ExperimentalAttribute';},
    #   @{Accelerator = [ExperimentalFeature];            FullName = 'System.Management.Automation.ExperimentalFeature';},
        @{Accelerator = [float];                          FullName = 'System.Single';},
        @{Accelerator = [single];                         FullName = 'System.Single';},
        @{Accelerator = [guid];                           FullName = 'System.Guid';},
        @{Accelerator = [hashtable];                      FullName = 'System.Collections.Hashtable';},
        @{Accelerator = [int];                            FullName = 'System.Int32';},
        @{Accelerator = [int32];                          FullName = 'System.Int32';},
    #   @{Accelerator = [short];                          FullName = 'System.Int16';},
        @{Accelerator = [int16];                          FullName = 'System.Int16';},
        @{Accelerator = [long];                           FullName = 'System.Int64';},
        @{Accelerator = [int64];                          FullName = 'System.Int64';},
        @{Accelerator = [ciminstance];                    FullName = 'Microsoft.Management.Infrastructure.CimInstance';},
        @{Accelerator = [cimclass];                       FullName = 'Microsoft.Management.Infrastructure.CimClass';},
        @{Accelerator = [cimtype];                        FullName = 'Microsoft.Management.Infrastructure.CimType';},
        @{Accelerator = [cimconverter];                   FullName = 'Microsoft.Management.Infrastructure.CimConverter';},
        @{Accelerator = [IPEndpoint];                     FullName = 'System.Net.IPEndPoint';},
    #   @{Accelerator = [NoRunspaceAffinity];             FullName = 'System.Management.Automation.Language.NoRunspaceAffinityAttribute';},
        @{Accelerator = [NullString];                     FullName = 'System.Management.Automation.Language.NullString';},
        @{Accelerator = [OutputType];                     FullName = 'System.Management.Automation.OutputTypeAttribute';},
        @{Accelerator = [ObjectSecurity];                 FullName = 'System.Security.AccessControl.ObjectSecurity';},
    #   @{Accelerator = [ordered];                        FullName = 'System.Collections.Specialized.OrderedDictionary';},
        @{Accelerator = [Parameter];                      FullName = 'System.Management.Automation.ParameterAttribute';},
        @{Accelerator = [PhysicalAddress];                FullName = 'System.Net.NetworkInformation.PhysicalAddress';},
        @{Accelerator = [pscredential];                   FullName = 'System.Management.Automation.PSCredential';},
        @{Accelerator = [PSDefaultValue];                 FullName = 'System.Management.Automation.PSDefaultValueAttribute';},
        @{Accelerator = [pslistmodifier];                 FullName = 'System.Management.Automation.PSListModifier';},
        @{Accelerator = [psobject];                       FullName = 'System.Management.Automation.PSObject';},
        @{Accelerator = [pscustomobject];                 FullName = 'System.Management.Automation.PSObject';},
        @{Accelerator = [psprimitivedictionary];          FullName = 'System.Management.Automation.PSPrimitiveDictionary';},
        @{Accelerator = [ref];                            FullName = 'System.Management.Automation.PSReference';},
        @{Accelerator = [PSTypeNameAttribute];            FullName = 'System.Management.Automation.PSTypeNameAttribute';},
        @{Accelerator = [regex];                          FullName = 'System.Text.RegularExpressions.Regex';},
        @{Accelerator = [DscProperty];                    FullName = 'System.Management.Automation.DscPropertyAttribute';},
        @{Accelerator = [sbyte];                          FullName = 'System.SByte';},
        @{Accelerator = [string];                         FullName = 'System.String';},
        @{Accelerator = [SupportsWildcards];              FullName = 'System.Management.Automation.SupportsWildcardsAttribute';},
        @{Accelerator = [switch];                         FullName = 'System.Management.Automation.SwitchParameter';},
        @{Accelerator = [cultureinfo];                    FullName = 'System.Globalization.CultureInfo';},
        @{Accelerator = [bigint];                         FullName = 'System.Numerics.BigInteger';},
        @{Accelerator = [securestring];                   FullName = 'System.Security.SecureString';},
        @{Accelerator = [timespan];                       FullName = 'System.TimeSpan';},
    #   @{Accelerator = [ushort];                         FullName = 'System.UInt16';},
        @{Accelerator = [uint16];                         FullName = 'System.UInt16';},
    #   @{Accelerator = [uint];                           FullName = 'System.UInt32';},
        @{Accelerator = [uint32];                         FullName = 'System.UInt32';},
    #   @{Accelerator = [ulong];                          FullName = 'System.UInt64';},
        @{Accelerator = [uint64];                         FullName = 'System.UInt64';},
        @{Accelerator = [uri];                            FullName = 'System.Uri';},
        @{Accelerator = [ValidateCount];                  FullName = 'System.Management.Automation.ValidateCountAttribute';},
        @{Accelerator = [ValidateDrive];                  FullName = 'System.Management.Automation.ValidateDriveAttribute';},
        @{Accelerator = [ValidateLength];                 FullName = 'System.Management.Automation.ValidateLengthAttribute';},
        @{Accelerator = [ValidateNotNull];                FullName = 'System.Management.Automation.ValidateNotNullAttribute';},
        @{Accelerator = [ValidateNotNullOrEmpty];         FullName = 'System.Management.Automation.ValidateNotNullOrEmptyAttribute';},
    #   @{Accelerator = [ValidateNotNullOrWhiteSpace];    FullName = 'System.Management.Automation.ValidateNotNullOrWhiteSpaceAttribute';},
        @{Accelerator = [ValidatePattern];                FullName = 'System.Management.Automation.ValidatePatternAttribute';},
        @{Accelerator = [ValidateRange];                  FullName = 'System.Management.Automation.ValidateRangeAttribute';},
        @{Accelerator = [ValidateScript];                 FullName = 'System.Management.Automation.ValidateScriptAttribute';},
        @{Accelerator = [ValidateSet];                    FullName = 'System.Management.Automation.ValidateSetAttribute';},
        @{Accelerator = [ValidateTrustedData];            FullName = 'System.Management.Automation.ValidateTrustedDataAttribute';},
        @{Accelerator = [ValidateUserDrive];              FullName = 'System.Management.Automation.ValidateUserDriveAttribute';},
        @{Accelerator = [version];                        FullName = 'System.Version';},
        @{Accelerator = [void];                           FullName = 'System.Void';},
        @{Accelerator = [ipaddress];                      FullName = 'System.Net.IPAddress';},
        @{Accelerator = [DscLocalConfigurationManager];   FullName = 'System.Management.Automation.DscLocalConfigurationManagerAttribute';},
        @{Accelerator = [WildcardPattern];                FullName = 'System.Management.Automation.WildcardPattern';},
        @{Accelerator = [X509Certificate];                FullName = 'System.Security.Cryptography.X509Certificates.X509Certificate';},
        @{Accelerator = [X500DistinguishedName];          FullName = 'System.Security.Cryptography.X509Certificates.X500DistinguishedName';},
        @{Accelerator = [xml];                            FullName = 'System.Xml.XmlDocument';},
        @{Accelerator = [CimSession];                     FullName = 'Microsoft.Management.Infrastructure.CimSession';},
        @{Accelerator = [mailaddress];                    FullName = 'System.Net.Mail.MailAddress';},
    #   @{Accelerator = [semver];                         FullName = 'System.Management.Automation.SemanticVersion';},
        @{Accelerator = [adsi];                           FullName = 'System.DirectoryServices.DirectoryEntry';},
        @{Accelerator = [adsisearcher];                   FullName = 'System.DirectoryServices.DirectorySearcher';},
        @{Accelerator = [wmiclass];                       FullName = 'System.Management.ManagementClass';},
        @{Accelerator = [wmi];                            FullName = 'System.Management.ManagementObject';},
        @{Accelerator = [wmisearcher];                    FullName = 'System.Management.ManagementObjectSearcher';},
        @{Accelerator = [scriptblock];                    FullName = 'System.Management.Automation.ScriptBlock';},
    #   @{Accelerator = [pspropertyexpression];           FullName = 'Microsoft.PowerShell.Commands.PSPropertyExpression';},
        @{Accelerator = [psvariable];                     FullName = 'System.Management.Automation.PSVariable';},
        @{Accelerator = [type];                           FullName = 'System.Type';},
        @{Accelerator = [psmoduleinfo];                   FullName = 'System.Management.Automation.PSModuleInfo';},
        @{Accelerator = [powershell];                     FullName = 'System.Management.Automation.PowerShell';},
        @{Accelerator = [runspacefactory];                FullName = 'System.Management.Automation.Runspaces.RunspaceFactory';},
        @{Accelerator = [runspace];                       FullName = 'System.Management.Automation.Runspaces.Runspace';},
        @{Accelerator = [initialsessionstate];            FullName = 'System.Management.Automation.Runspaces.InitialSessionState';},
        @{Accelerator = [psscriptmethod];                 FullName = 'System.Management.Automation.PSScriptMethod';},
        @{Accelerator = [psscriptproperty];               FullName = 'System.Management.Automation.PSScriptProperty';},
        @{Accelerator = [psnoteproperty];                 FullName = 'System.Management.Automation.PSNoteProperty';},
        @{Accelerator = [psaliasproperty];                FullName = 'System.Management.Automation.PSAliasProperty';},
        @{Accelerator = [psvariableproperty];             FullName = 'System.Management.Automation.PSVariableProperty';}
    )

    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $TestData.Add(@{Accelerator = [ArgumentCompletions]; FullName = 'System.Management.Automation.ArgumentCompletionsAttribute'})
        $TestData.Add(@{Accelerator = [ExperimentalAction]; FullName = 'System.Management.Automation.ExperimentalAction'})
        $TestData.Add(@{Accelerator = [Experimental]; FullName = 'System.Management.Automation.ExperimentalAttribute'})
        $TestData.Add(@{Accelerator = [ExperimentalFeature]; FullName = 'System.Management.Automation.ExperimentalFeature'})
        $TestData.Add(@{Accelerator = [short]; FullName = 'System.Int16'})
        $TestData.Add(@{Accelerator = [NoRunspaceAffinity]; FullName = 'System.Management.Automation.Language.NoRunspaceAffinityAttribute'})
        $TestData.Add(@{Accelerator = [ordered]; FullName = 'System.Collections.Specialized.OrderedDictionary'})
        $TestData.Add(@{Accelerator = [ushort]; FullName = 'System.UInt16'})
        $TestData.Add(@{Accelerator = [uint]; FullName = 'System.UInt32'})
        $TestData.Add(@{Accelerator = [ulong]; FullName = 'System.UInt64'})
        $TestData.Add(@{Accelerator = [ValidateNotNullOrWhiteSpace]; FullName = 'System.Management.Automation.ValidateNotNullOrWhiteSpaceAttribute'})
        $TestData.Add(@{Accelerator = [semver]; FullName = 'System.Management.Automation.SemanticVersion'})
        $TestData.Add(@{Accelerator = [pspropertyexpression]; FullName = 'Microsoft.PowerShell.Commands.PSPropertyExpression'})
    }
}

AfterAll {
    Get-Module -Name 'HelperModule' | Remove-Module -Force -Verbose
    Get-Module -Name 'TypeAccelerator' | Remove-Module -Force -Verbose
}

BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '.\TypeAccelerator.psd1'
    Import-Module -Name $ModulePath -Verbose
}

Describe 'TypeAccelerator Unit Tests' {
    Context 'TypeAccelerator Module' {
        It 'should have a RootModule of TypeAccelerator.psm1' {
            # Arrange and Act
            $RootModule = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'RootModule'
    
            # Assert
            $RootModule | Should -Be 'TypeAccelerator.psm1'
        }
    
        It 'should have a ModuleVersion of 0.0.1' {
            # Arrange and Act
            $ModuleVersion = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'Version'
            
            # Assert
            $ModuleVersion | Should -Be '0.0.1'
        }
    
        It 'should have a GUID of 821cb68a-a769-4432-a70e-6a70b6e0de29' {
            # Arrange and Act
            $Guid = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'GUID'
    
            # Assert
            $Guid | Should -Be '821cb68a-a769-4432-a70e-6a70b6e0de29'
        }
    
        It 'should have an Author of John Merryweather Cooper' {
            # Arrange and Act
            $Author = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'Author'
            
            # Assert
            $Author | Should -Be 'John Merryweather Cooper'
        }
    
        It 'should have a CompanyName of Ram Tuned Mega Code' {
            # Arrange and Act
            $CompanyName = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'CompanyName'
            
            # Assert
            $CompanyName | Should -Be 'Ram Tuned Mega Code'
        }
    
        It 'should have a Copyright of Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.' {
            # Arrange and Act
            $Copyright = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'Copyright'
            
            # Assert
            $Copyright | Should -Be 'Copyright (c) 2024, John Merryweather Cooper.  All Rights Reserved.'
        }
    
        It 'should have a Description of Library of cmdlets/functions to register type accelerators.' {
            # Arrange and Act
            $Description = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'Description'
    
            # Assert
            $Description | Should -Be 'Library of cmdlets/functions to register type accelerators.'
        }
    
        It 'should have a PowerShellVersion of 5.1' {
            # Arrange and Act
            $PowerShellVersion = Test-ModuleManifest -Path '.\TypeAccelerator.psd1' | Select-Object -ExpandProperty 'PowerShellVersion'
    
            # Assert
            $PowerShellVersion | Should -Be '5.1'
        }

        It -Name 'Has methods' -ForEach $MethodList -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath $_)
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path $testPathSplat | Should -BeTrue
        }

        It -Name 'Has correct path' -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = $ModulePath | Resolve-Path

            # Act
            $Actual = Test-ModuleManifest -Path $Expected | Select-Object -ExpandProperty Path | Resolve-Path

            # Assert
            $Actual | Should -Be $Expected
        }
    }
}

Describe 'Add-TypeAccelerator Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Add-TypeAccelerator')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Mock Add-TypeAccelerator and prove invoked' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            Mock -CommandName 'Add-TypeAccelerator' -ModuleName 'TypeAccelerator' -MockWith {
                Write-Information -MessageData "Mocked Add-TypeAccelerator -ExportableType '[$($FullName)]' -InvocationInfo <MyInvocationInfo>" -InformationAction Continue
                $ExportableTypeState['ExportableType'] = $FullName
                $ExportableTypeState['InvocationInfo'] = $MyInvocation
            }

            # Act
            Add-TypeAccelerator -ExportableType $Accelerator -InvocationInfo $MyInvocation

            # Assert
            Should -Invoke 'Add-TypeAccelerator' -Exactly 1
        }

        It -Name 'Mock Add-TypeAccelerato and global state should match' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            Mock -CommandName 'Add-TypeAccelerator' -ModuleName 'TypeAccelerator' -MockWith {
                Write-Information -MessageData "Mocked Add-TypeAccelerator -ExportableType '[$($FullName)]' -InvocationInfo <MyInvocationInfo>" -InformationAction Continue
                $ExportableTypeState['ExportableTypeName'] = $FullName
                $ExportableTypeState['InvocationInfo'] = $MyInvocation
            }

            # Act
            Add-TypeAccelerator -ExportableType $Accelerator -InvocationInfo $MyInvocation

            # Assert
            $ExportableTypeState['ExportableTypeName'] | Should -Be $FullName
        }
    }
}

Describe 'Get-TypeAccelerator Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Get-TypeAccelerator')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Get-TypeAccelerator -ListAvailable gets count TypeAccelerators' -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = 107

            # Act
            $Actual = Get-TypeAccelerator -ListAvailable | Select-Object -ExpandProperty Count

            # Assert
            $Actual | Should -Be $Expected
        }

        It -Name 'Get-TypeAccelerator -ListAvailable gets all TypeAccelerators Accelerators' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = ($Accelerator -as [type])

            # Act
            $Actual = Get-TypeAccelerator -ListAvailable | Where-Object -Property Key -EQ $Accelerator

            # Assert
            $Actual | Should -Be $Expected
        }

        It -Name 'Get-TypeAccelerator -ListAvailable gets all TypeAccelerators FullNames' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = $FullName

            $Actual = Get-TypeAccelerator -ListAvailable | Where-Object -Property Value -EQ $FullName

            # Assert
            $Actual | Should -Be $Expected
        }
    }
}

Describe 'Get-TypeAcceleratorClass Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Get-TypeAcceleratorClass')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Get-TypeAcceleratorClass should not be null' -Tag @('Unit', 'Test') {
            # Arrange and Act
            $result = Get-TypeAcceleratorClass

            # Assert
            $result | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Register-TypeAccelerator Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Register-TypeAccelerator')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Mock Register-TypeAccelerator' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            Mock -CommandName 'Register-TypeAccelerator' -ModuleName 'TypeAccelerator' -MockWith {
                Write-Information -MessageData "Mocked Register-TypeAccelerator -ExportableType '[$($_.Name)]'" -InformationAction Continue
            }

            # Act
            Register-TypeAccelerator -ExportableType $Accelerator

            # Assert
            Should -Invoke 'Register-TypeAccelerator' -Exactly 1
        }
    }
}

Describe 'Remove-TypeAccelerator Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Remove-TypeAccelerator')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Mock Remove-TypeAccelerator' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            Mock -CommandName 'Remove-TypeAccelerator' -ModuleName 'TypeAccelerator' -MockWith {
                Write-Information -MessageData "Mocked Remove-TypeAccelerator -ExportableType '[$($_.Name)]'" -InformationAction Continue
            }

            # Act
            Remove-TypeAccelerator -ExportableType $Accelerator

            # Assert
            Should -Invoke 'Remove-TypeAccelerator' -Exactly 1
        }
    }
}

Describe 'Test-TypeAcceleratorRegistered Unit Tests' {
    Context 'Exits' {
        It -Name 'Exists in TypeAccelerator' -Tag @('Unit', 'Test') {
            # Arrange
            $testPathSplat = @{
                LiteralPath = (Join-Path -Path function:\ -ChildPath 'Test-TypeAcceleratorRegistered')
                PathType = 'Leaf'
            }

            # Act and Assert
            Test-Path @testPathSplat | Should -BeTrue
        }

        It -Name 'Test-TypeAcceleratorRegistered against TestData' -ForEach $TestData -Tag @('Unit', 'Test') {
            # Arrange
            $Expected = $TestData.Length

            # Act
            $Actual = Get-TypeAccelerator -ListAvailable | Select-Object -ExpandProperty Count

            # Assert
            Test-TypeAcceleratorRegistered -ExportableType $Accelerator | Should -BeTrue
        }
    }
}