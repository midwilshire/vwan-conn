[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [string]$VirtualWanHubResourceId,
    [string]$VirtualNetworkResourceId,
    [string]$ConnectionName
)

$resourceGroup = $VirtualWanHubResourceId.Split("/")[4]
$virtualHubName = $VirtualWanHubResourceId.Split("/")[8]

If (-NOT(Get-Module -ListAvailable Az.Network)) {
    Write-Warning "This script requires the Az.Network module."

    Install-Module Az.Network -Scope CurrentUser -Force
}

Get-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup -VirtualHubName $virtualHubName -Name $ConnectionName | Remove-AzVirtualHubVnetConnection