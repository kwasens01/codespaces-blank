[CmdletBinding()]
param (
    [Parameter()]
    #[ValidateSet("Vs2022", "Vs2019","VsCode","VsCodePrv","Raw")]
    [string] $BranchName,
    [string] $NewBranchName,
    [string] $RemoteRepoName = 'origin',
    [string] $LocalRepoPath = '.'

)
function RunMain($noDryRun) {
    <#
XREF:  
    https://forum.gitlab.com/t/how-to-rename-a-branch-in-gitlab/30746

    #Checkout the branch locally.
    $ git checkout branch

    #Rename it locally: as branch_new
    $ git checkout -b branch_new

    #delete remote branch
    $ git push --delete origin branch

    #push the locally renamed branch to remote.
    git push --set-upstream origin branch_new
#>

    #git checkout $BranchName
    # git checkout -b $NewBranchName
    # git push --delete $RemoteRepoName $BranchName
    # git push --set-upstream $RemoteRepoName $NewBranchName
    
    Push-Location $LocalRepoPath;
    #Set-Location -Path $LocalRepoPath

    #Checkout the branch locally.
    git checkout $BranchName

    #Rename it locally: as branch_new
    git checkout -b $NewBranchName

    #delete remote branch
    git push --delete $RemoteRepoName $BranchName

    #push the locally renamed branch to remote.
    git push --set-upstream $RemoteRepoName $NewBranchName

    Pop-Location;

}

$runTest = $true; # $false;

if ($runTest) {
    $NoDryRun = $false
    $BranchName = "feature0/main"; #"dev00";
    $NewBranchName ="feature01/main";
    $RemoteRepoName = "origin";
    $LocalRepoPath = "/workspaces/codespaces-blank"; #C:\Users\asensoh_k\source\repos\zTmp\_gitLab_scratch\test-project-01";

}
RunMain -noDryRun $NoDryRun;