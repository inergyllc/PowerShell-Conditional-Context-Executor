# This gets placed at the bottom of the function script you wish to test

# You do not need to set/reset the VerbosePreference unless you want to see the
# the harness run (or not see it)
$VerbosePreference = "SilentlyContinue" # Do not write the verbose text to console
# $VerbosePreference = "Continue" # Write the verbose text to console

# This is what will get executed if the source is ISE,VSCODE,Terminal,Windows Click
$command = @"
Test-ForContext -Message "This is the test message"
"@

. 'D:\source\PowerShell Context Manager\NotInContextExecutor.ps1'

