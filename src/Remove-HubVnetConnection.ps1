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

$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

Get-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup -VirtualHubName $virtualHubName -Name $ConnectionName | Remove-AzVirtualHubVnetConnection