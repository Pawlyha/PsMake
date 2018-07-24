.nuget\nuget.exe install Pester -Version 3.3.6 -OutputDirectory libs -ConfigFile .nuget\nuget.Config -ExcludeVersion
Import-Module $PSScriptRoot\libs\Pester\tools\Pester.psm1
Invoke-Pester psmake.mod.testing* -OutputFile report.xml -OutputFormat NUnitXml -EnableExit
if(!($?)) { Write-Error "Some tests have failed." }
