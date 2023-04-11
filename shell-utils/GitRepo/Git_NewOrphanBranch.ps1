[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("VisualStudio", "Empty", "None")]
    [string] $GitIgnoreType = 'VisualStudio',
    [string] $BranchName,
    [switch] $NoDryRun
)

#region functions ====================
function Emulator([string] $cmdLine, [bool] $localDryRun, [bool] $globalDryRun ) {
    if ($localDryRun) {
        Write-Output $cmdLine;      
    }
    elseif ($globalDryRun) {
        Write-Output $cmdLine;  
    }
    else {
        Invoke-Expression -Command $cmdString;
    }
}
function Emu {
    param(
        [string] $cmdLine,
        [switch] $localDryRun
    )
    [bool] $globalDryRun = (-not $NoDryRun)    
    Emulator -cmdLine $cmdLine -localDryRun $localDryRun -globalDryRun $globalDryRun
}
#endregion

#region Main ====================
function RunMain(   
    [string] $GitIgnoreType0,
    [string] $BranchName0,
    [switch] $noDryRun0) {
    
    #$ModuleSrcFolderName = 'Modules';
    $GitLibraryFolderName = 'git-library';
    $myPSScriptRootStr = $PSScriptRoot;
    if ($myPSScriptRootStr.Length -eq 0 ) { $MyPSScriptRootStr = "." }
    #$gitLibraryPath = Resolve-Path -Path (Join-Path -path  "$myPSScriptRootStr/../git-library" -ChildPath $ModuleSrcsFileName) ;
    $gitLibraryPath = Resolve-Path -Path ("$myPSScriptRootStr/$GitLibraryFolderName");

    $gitIgnoreName = "";
    $gitIgnorePath = Join-Path -path  $gitLibraryPath -ChildPath "vs-gitignore.txt";
    
    switch ($GitIgnoreType0) {
        "VisualStudio" { $gitIgnoreName = "vs-gitignore.txt"; Break }
        "Empty" { $gitIgnoreName = "blank-gitignore.txt"; Break }
        Default {
            $gitIgnoreName = "";
            "No GitIgnore"
        }
    }
    if ($gitIgnoreName.Length -gt 0) { $gitIgnorePath = Join-Path -path  $gitLibraryPath -ChildPath $gitIgnoreName; }
    

    #     $cmdString = @"
    #         #git switch --orphan deploy/dev
    #         Get-ChildItem .
    #         tree
    # "@
    $cmdString = @"
    git switch --orphan $BranchName;
    Copy-Item -Path $gitIgnorePath -Destination ./.gitignore;
    git add .;
    git commit -m "Create new orphaned branch";
"@

    Emu -cmdLine $cmdString  # -localDryRun  # $true -globalDryRun  (-not $NoDryRun) ;
    ##Invoke-Expression -Command $cmdString;
}
#endregion




$runTest = $true;

if ($runTest) {
    $NoDryRun = $NoDryRun;# $false;# $true;# $false;
    $BranchName = "environ--dev";
    $GitIgnoreType = "VisualStudio";
    #Push-Location C:\Users\asensoh_k\source\repos\zTmp\_gitLab_scratch\test-project-01
}
RunMain -BranchName0 $BranchName  -GitIgnoreType0 $GitIgnoreType -noDryRun $NoDryRun;
if ($runTest) {
  #  Push-Location;
}