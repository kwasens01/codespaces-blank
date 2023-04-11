[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("Development", "Production", "Test", "Custom")]
    [string] $EnvironName = 'Development',
    [string] $CustomName
)
