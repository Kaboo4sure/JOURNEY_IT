#        Date                               Who                                Update
#       April 6th, 2025                   Taofeek                              Created a script to start and stop service






param (
    [Parameter(Mandatory = $true)]
    [string]$Action  # Accepts either 'Start' or 'Stop'
)


# Check if script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Not running as Administrator. Relaunching as Admin..."
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}


$serviceName = "js7_agent_4445"
$service = Get-Service -Name $serviceName

if ($Action -eq "Stop") {
    if ($service.Status -eq "Stopped") {
        Write-Host "The JS7 agent is already stopped."
    } else {
        Write-Host "JS7 agent is about to be stopped..."
        Stop-Service -Name $serviceName -Force
        Write-Host "JS7 agent has been stopped successfully."
    }
} elseif ($Action -eq "Start") {
    if ($service.Status -eq "Running") {
        Write-Host "The JS7 agent is already running."
    } else {
        Write-Host "JS7 agent is about to be started..."
        Start-Service -Name $serviceName
        Write-Host "JS7 agent has been started successfully."
    }

} else {
    Write-Host "Invalid action specified. Please use 'Start' or 'Stop'."
}