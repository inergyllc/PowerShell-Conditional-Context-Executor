# What is a Conditional Executor
I have literally thousands of PowerShell scripts developed over the years. Most, though not all, are some form of function

   ```powershell
    Define a function to demonstrate verbose and non-verbose messages
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
   ```
I like to test my code in the IDE I am currently using.  So, along with the scripts came hundreds of test harnesses.  Too many harnesses.  An ocean of harnesses.  Eventually, I sat down and knocked out a scripting method that let me leave my test code in my scripts.  The Executor ignores test code when not being run directly from within an IDE or as a simple call from the Terminal (or a Window click).

The Executor got more and less complex over time.  Here is the final version I settled on.  I hope you find the ability to embed test code in your scripts, ignored at contextual runtime.  I use it all of the time.  The two lines at the bottom of the preceding scripts is all it requires, once you have the NotInContextExecutor.ps1 placed in a known location.

# Overview

The `NotInContextExecutor.ps1` script is a utility designed to allow developers to embed test code within their PowerShell function scripts without executing it unless explicitly desired. This allows for seamless testing and development without interfering with production code.

## Purpose

The primary purpose of `NotInContextExecutor.ps1` is to enable developers to leave test code within their PowerShell scripts, which can be executed conditionally. This means that the test code will only run when explicitly called upon, allowing developers to test their scripts without the risk of running test code in production environments.

## Usage Guide

To effectively utilize the `NotInContextExecutor.ps1`, follow these instructions:

### Prerequisites

1. Ensure that you have PowerShell installed on your machine.
2. Make sure you have access to the `NotInContextExecutor.ps1` script.

### Steps to Use `NotInContextExecutor.ps1`

1. **Include the Executor in Your Script**

   At the end of your PowerShell script file that contains your function, include the `NotInContextExecutor.ps1` by dot-sourcing it. This will allow you to conditionally execute test code when needed.

```powershell
$command = @"
Test-ForContext -m "Test message to pass to function"
"@
. "path\to\NotInContextExecutor.ps1"
```

### Example of Function Script
Here is an example of a PowerShell script with a function that uses the NotInContextExecutor.ps1 for conditional testing:

```powershell
function Test-ForContext {
    param (
        [string]$CustomMessage = "This is a test message."
    )

    Write-Host "Function Execution: $CustomMessage" -ForegroundColor Green
}
# Include the executor script
$command = @"
Test-ForContext -m "Test message to pass to function"
"@
. "path\to\NotInContextExecutor.ps1"
```

## Using the Harness

To test your script using the NotInContextExecutor.ps1, you can use a test harness script similar to **TestCallHarness - INCLUDE AT END OF PS1 FUNCTION SCRIPT.ps1**. This script will set up the execution context and run your test code under the specified conditions.

## Verbose Mode
To observe the harness in action, you can modify the $VerbosePreference variable. By default, PowerShell's verbose output is set to SilentlyContinue, meaning it does not display verbose messages. Changing it to Continue will enable you to see detailed messages about the execution process.

```powershell
# Set verbose preference to display messages
$VerbosePreference = "Continue"
```

### Set verbose preference to display messages

```powershell
   $VerbosePreference = "Continue"
```

## Explanation of Usage
The NotInContextExecutor.ps1 script acts as a conditional executor, checking the execution context and ensuring that embedded test code only runs when intended. This is particularly useful for developers who want to maintain test code within their scripts without risking accidental execution in production environments.

By leveraging this utility, you can maintain clean, testable PowerShell scripts that only execute test code when you're ready to do so, keeping your production environments safe and reliable.

# Summary
**Purpose:** Allows conditional execution of test code within PowerShell scripts.
**Usage:** Include NotInContextExecutor.ps1 in your script and use a harness to execute test code.
**Verbose Mode:** Set $VerbosePreference to "Continue" to observe the execution process.
**Benefit:** Maintains test code without risking production execution.

With this setup, you can confidently develop and test your PowerShell scripts, knowing that test code will only run when explicitly triggered.

