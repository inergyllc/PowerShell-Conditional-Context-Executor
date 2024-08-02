clear
Write-Host "`$PSCommandPath                      = [$PSCommandPath]"
Write-Host "`$MyInvocation.PSCommandPath         = [$MyInvocation.PSCommandPath]"
Write-Host "`$host.Name                          = [$host.Name]"

[string]$strPSCommandPath             = [string]$PSCommandPath
[string]$strMyInvocationPSCommandPath = [string]$MyInvocation.PSCommandPath
[string]$strhostName                  = [string]$host.Name
Write-Host

Write-Host "[string]`$PSCommandPath              = $strPSCommandPath"
Write-Host "[string]`$MyInvocation.PSCommandPath = $strMyInvocationPSCommandPath"
Write-Host "[string]`$host.Name                  = $strhostName"