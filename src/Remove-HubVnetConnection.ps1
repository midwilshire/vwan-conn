[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [string]$VirtualWanHubResourceId,
    [string]$VirtualNetworkResourceId,
    [string]$ConnectionName
)

$resourceGroup = $VirtualWanHubResourceId.Split("/")[4]
$virtualHubName = $VirtualWanHubResourceId.Split("/")[8]

Get-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup -VirtualHubName $virtualHubName -Name $ConnectionName | Remove-AzVirtualHubVnetConnection