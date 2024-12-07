BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'TaskAccelerator.psd1' -Resolve
    Import-Module $modulePath -Force -Verbose
    $HelperModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\Vine\Vine.psd1' -Resolve
    Import-Module $HelperModulePath -Force -Verbose

    $MethodList = @(
        'Add-TypeAccelerator',
        'Get-TypeAccelerator',
        'Get-TypeAcceleratorClass',
        'Register-TypeAccelerator',
        'Remove-TypeAccelerator',
        'Test-TypeAccelerator'
    )
}

AfterAll {
    Get-Module -Name 'HelperModule' | Remove-Module -Force
    Get-Module -Name 'TaskAccelerator' | Remove-Module -Force
}

Descrivw 'TypeAccelerator Tests' {
    Context 'Vine Class' {
        It 'Should have a default constructor' {
            $vine = [Vine]::new()
            $vine | Should -BeOfType [Vine]
        }

        It 'Should have a constructor that takes a Type' {
            $vine = [Vine]::new([object])
            $vine | Should -BeOfType [Vine]
        }

        It 'Should have a constructor that takes a Value and a Type' {
            $vine = [Vine]::new([object], [object])
            $vine | Should -BeOfType [Vine]
        }

        It 'Should have a constructor that takes a hashtable' {
            $vine = [Vine]::new(@{Type = [object]; Value = [object]})
            $vine | Should -BeOfType [Vine]
        }

        It 'Should have a method AsType' {
            $vine = [Vine]::new()
            $type = $vine.AsType()
            $type | Should -BeOfType [type]
        }
    }
}