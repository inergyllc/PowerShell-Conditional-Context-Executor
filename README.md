# PowerShell Conditional Context Executor

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
   # At the end of your script
   . "path\to\NotInContextExecutor.ps1"

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
. "path\to\NotInContextExecutor.ps1"
```
## Using the Harness

To test your script using the NotInContextExecutor.ps1, you can use a test harness script similar to TestCallHarness - INCLUDE AT END OF PS1 FUNCTION SCRIPT.ps1. This script will set up the execution context and run your test code under the specified conditions.
