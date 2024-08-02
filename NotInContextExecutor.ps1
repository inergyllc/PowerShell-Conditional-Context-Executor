# Fix input parameters (from user)
if (-not [string]::IsNullOrWhiteSpace($command)) {
    $command = $command.Trim()
}

if ([string]::IsNullOrWhiteSpace($command)) {
    Write-Error 'Cannot have null $command parameter'
    exit
}

# Cannot use this from anything but the core script
$stack = (Get-PSCallStack | Where-Object { $_.Command -ne "<ScriptBlock>" })
$stackDepth = $stack.Count
Write-Verbose "STACK DEPTH IN CONTEXT $stackDepth"
foreach($s in $stack) {
    Write-Verbose $s.ScriptName
}

# Get the depth of the call stack
if ($stackDepth -gt 2 ) {
    # Execution is within a deeper call stack
    Write-Verbose "NO EXECUTE: Stack depth $stackDepth is too deep for direct execution"
    return
}

# You can add your own hosts if you use other IDEs. I do not
$validHostNames = @( `
    'Windows PowerShell ISE Host', `
    'Visual Studio Code Host')
[string]$hostName = $host.Name
$isExecutingFromValidHost = $hostName -iin $validHostNames
if ($isExecutingFromValidHost) {
    Write-Host "EXECUTE OK: Is executing from valid host"
}

# Does not work from deeper than a single call.  Cannot use deep in stack
# Execution within a script context
$stacked1Script = $stack[1].ScriptName
$stacked1PsCommand = $stack[1].Command

# Test to see if we are executing from the expected context
[string]$myInvocationPsCommandPath = $MyInvocation.PSCommandPath
$isExecutingDirectly = `
    (-not [string]::IsNullOrWhiteSpace($stacked1Script) `
    -and $stacked1Script -eq $myInvocationPsCommandPath)
if ($isExecutingDirectly) {
    Write-Verbose "EXECUTE OK: Stacked script equals MyInvocation.PSCommandPath"
} else {
    $isExecutingDirectly = [string]::IsNullOrWhiteSpace($myInvocationPsCommandPath)
    if ($isExecutingDirectly) {
        Write-Verbose "EXECUTE OK: MyInvocation.PSCommandPath is null"
    }
}

# If valid host or direct execut4ion, go ahead with test
$isOkayToExecute = $isExecutingFromValidHost -or $isExecutingDirectly
Write-Verbose "PSCommandPath              : $PSCommandPath"
Write-Verbose "MyInvocation.PSCommmandPath: $myInvocationPsCommandPath"
Write-Verbose "host.Name                  : $hostName"
Write-Verbose "isOkayToExecute            : $isOkayToExecute"
Write-Verbose "stackDepth                 : $stackDepth"
Write-Verbose "stacked1Script             : $stacked1Script"
Write-Verbose "stacked1PsCommand          : $stacked1PsCommand"
if (-not $isOkayToExecute) {
    Write-Host "Cannot execute."
    exit
}

# Run command if specified.  If not specified, assumes code is not a function but a script
if (-not [string]::IsNullOrWhiteSpace($command)) {
    try {
        Invoke-Expression $command
    }
    catch {
        Write-Host "HARNESS ERROR: Execute failed [$command]" -ForegroundColor Red
        Write-Host 'HARNESS ERROR: Check $command for correctness.' -ForegroundColor Red
    }
}
