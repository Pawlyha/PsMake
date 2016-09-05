
<#
.SYNOPSIS 
Executes JavaScript Jasmine Tests 

.DESCRIPTION

.EXAMPLE

.EXAMPLE

.EXAMPLE

#>

function Define-UIJasmineTests
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        # Test group name. Used for display as well as naming reports. 
        [ValidateNotNullOrEmpty()]
        [Alias('Name','tgn')]
        [string]$GroupName,

        [Parameter(Mandatory=$true, Position=1)]
        # Path to nodejs.exe.
        # It is possible to specify multiple paths.
        [ValidateNotNullOrEmpty()]
        [Alias('npath','node')]
        [string]$NodePath,

        [Parameter()]
        # Test report name. If not specified, a GroupName parameter would be used (spaces would be converted to underscores). 
        [AllowNull()]
        [string]$ReportName = $null,

        [Parameter()]
        # Jasmine.Runner.Console version. By default it is: 2.0.0
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("^[0-9]+(\.[0-9]+){0,3}$")]
        [Alias('RunnerVersion')]
        [string]$JasmineRunnerVersion = "1.0.0"
    )

    if (($ReportName -eq $null) -or ($ReportName -eq '')) { $ReportName = $GroupName -replace ' ','_' }

    Create-Object @{
        Package='jasmine.runner.console';
        PackageVersion=$JasmineRunnerVersion;
        GroupName=$GroupName;
        ReportName=$ReportName;
    }
}

<#
.SYNOPSIS 

.DESCRIPTION


.EXAMPLE

.EXAMPLE


.EXAMPLE

#>

function Run-UI-Tests
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=1)]
        # Path to nodejs.exe.
        # It is possible to specify multiple paths.
        [ValidateNotNullOrEmpty()]
        [Alias('npath','node')]
        [string]$NodeDirPath
    )
    begin
    {
        #. $PSScriptRoot\internals.ps1
        #Prepare-ReportDirectory $ReportDirectory $EraseReportDirectory
        
        Write-Host "Start"
        
        $Npm = Join-Path $NodeDirPath -ChildPath "npm"
        $Node = Join-Path $NodeDirPath -ChildPath "node.exe"
        $KarmaConfigPath = Join-Path -Path $(Get-Location) -ChildPath "karma.conf.js"

        if (-Not (Test-Path $KarmaConfigPath)) {
            Write-Host "Karma configuration file is not defined!"
            return
        }
    }

    process
    {
        Write-Host "UI Tests are running.."
        Start-Process $Npm install -Wait
        Write-Host "packages are installed"
        . $Node "node_modules/karma/bin/karma" "start"
        Write-Host "UI Tests finished"
    }

    end
    {
        return
    }
}