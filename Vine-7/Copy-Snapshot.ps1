[CmdletBinding()]
param ()

Copy-Item -Path .\VineSnapshot\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\ConvertModule\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\COutModule\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\HelperModule\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\MessageModule\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\RandomModule\*.ps?1 -Destination ..\Vine
Copy-Item -Path ..\TypeAccelerator\*.ps?1 -Destination ..\Vine