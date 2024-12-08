# Source for the Book "Test Driven Design for PowerShell Classes"

### By John Merryweather Cooper

Snapshots of source:

## Vine-0

Initial Red-Green Unit Tests setting the design.

* the constructors

  * Vine()
  * New-Vine
    * Output type [Vine]
  * New-Object -TypeName 'Vine'
    * Output type [Vine]

* the method
  * [void]Dispose()

## Vine-1

Refinements to:

* the constructors

  * Vine()
  * Vine([object])
  * Vine([object], [Type])
  * New-Vine -Value [object] -Type [type]
    * Output type [Vine]
  * New-Object -TypeName 'Vine' -ArgumentList [object], [type]
    * Output type [Vine]

* the public properties

  * [string]FullName property
  * [string]Name property
  * [string]Namespace property
  * [type]Type property
  * [object]Value property

* the public, hidden property
  * [bool]Diposed hidden property

* the public method
  * [void]Clear() method
  * [void]Dispose() method

## Vine-2

Refinements to:

* add support for registering a TypeAccelerator
* static [void]Swap([Vine], [Vine]) method

## Vine-3

Refinements to:

* Equals([Vine]) method
* static Equals([Vine], [Vine]) method
* GetHashCode() method
* NotEquals([Vine]) method
* static NotEquals([Vine], [Vine]) method

## Vine-4

Refinement to:

* [void]Emplace([object]) method
* [void]Emplace([object], [Type])
* [void]Emplace([Vine])

## Vine-5

Refinement to:

* [object]Cast([Type]) method

## Vine-6

Refinement to:

* [bool]HasValue() method

## Vine-7

Refinement to:

* [type]AsType()
* [string]ToString()

## Vine-8

Refinement to: 

* static [type]BaseType([Vine])
* static [bool]CanConvert([Vine], [Vine])
* static [type]DeclaringType([Vine])
* static [bool]HasElementType([Vine])
* static [bool]IsArray([Vine])
* static [bool]IsAssignableFrom([Vine], [Vine])
* static [bool]IsAssignableTo([Vine], [Vine])
* static [bool]IsClass([Vine])
* static [bool]IsInstanceOfType([Vine], [Vine])
* static [bool]IsSubclassOf([Vine], [Vine])
* static [bool]IsValueType([Vine])
