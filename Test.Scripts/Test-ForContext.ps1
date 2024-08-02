# Define a function to demonstrate verbose and non-verbose messages
function Test-ForContextInScript {
    <#
    .SYNOPSIS
        Demonstrates the use of verbose and non-verbose write commands in PowerShell.
    .DESCRIPTION
        This function shows how to manage and display messages based on verbosity settings,
        providing insights into script execution context and environment details.
    .PARAMETER CustomMessage
        An optional custom message to display during the demonstration.
    .EXAMPLE
        Test-ForContext -CustomMessage "Hello, World!"
    .EXAMPLE
        Test-ForContext -Verbose
    #>

    [CmdletBinding()]
    param (
        [string]$Message = "This is a test message."
    )

    # Function to demonstrate verbose and non-verbose messages
    function Test-Verbose {
        param (
            [string]$Message
        )

        # Display the message only when verbosity is enabled, useful for debugging
        Write-Verbose "$Message"

        # Always display this message, highlights important information in the script
        Write-Host "REGULAR: $Message" -ForegroundColor Green
    }

    # Main function execution
    # Announce the script's operation with dynamic verbosity state display
    Write-Host "RUNNING TEST SCRIPT (VERBOSE = " -NoNewline -ForegroundColor Magenta
    Write-Host "Cyan Text" -NoNewline -ForegroundColor Cyan
    Write-Host ")" -ForegroundColor Magenta

    # Visual separator for clarity in console output
    $dashLine = "- " * 45
    Write-Host $dashLine

    # Provide context and environment information, useful for understanding script's execution environment
    Write-Host "Script and Host Information:" -ForegroundColor Green

    # Check for null or empty states and provide clear indicators, enhancing diagnostics
    $psCommandPathValue = if ([string]::IsNullOrWhiteSpace($PSCommandPath)) { "<null>" } else { $PSCommandPath }
    $myInvocationValue = if ([string]::IsNullOrWhiteSpace($MyInvocation.PSCommandPath)) { "<null>" } else { $MyInvocation.PSCommandPath }
    $hostNameValue = if ([string]::IsNullOrWhiteSpace($host.Name)) { "<null>" } else { $host.Name }
    $verboseLevel = $VerbosePreference

    # Display current execution path, host, and verbosity settings, crucial for understanding script's runtime context
    Write-Host '     $PSCommandPath             : ' -NoNewline; Write-Host "$psCommandPathValue" -ForegroundColor Green
    Write-Host '     $MyInvocation.PSCommandPath: ' -NoNewline; Write-Host "$myInvocationValue" -ForegroundColor Green
    Write-Host '     $host.Name                 : ' -NoNewline; Write-Host "$hostNameValue" -ForegroundColor Green
    Write-Host '     $VerbosePreference         : ' -NoNewline; Write-Host "$verboseLevel" -ForegroundColor Green
    Write-Host $dashLine

    # Inform the user about verbose test operations
    Write-Host "Verbose Test Information:" -ForegroundColor Green

    # Perform a test message display to showcase the use of verbosity in enhancing script debugging
    Test-Verbose -Message $Message

    # Mark the end of the test script execution, indicating completion of operations
    Write-Host "TEST SCRIPT COMPLETE" -ForegroundColor Magenta
}


$command = 'Test-ForContext -Message "test message"'
. 'D:\source\PowerShell Context Manager\NotInContextExecutor.ps1'
