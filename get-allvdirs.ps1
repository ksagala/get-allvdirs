#
# Script listing all virtual directories and names used by all Exchange servers in organization
#
# version 1.3 updated to Exchange 2016 RTM (15.1)
#
# version 1.2, focusing on MAPI HTTP
# Updated to Exchange 2013 SP1
#

$ExOrgCfg = Get-OrganizationConfig
if ($ExOrgCfg.AdminDisplayVersion.ExchangeBuild.Major -eq 15)
	{
	if ((($ExOrgCfg.RBACConfigurationVersion.ExchangeBuild.Build -ge 847) -and ($ExOrgCfg.RBACConfigurationVersion.ExchangeBuild.Minor -eq 0)) -or ($ExOrgCfg.RBACConfigurationVersion.ExchangeBuild.Minor -eq 1))
	{
		$vdirs = @("Activesync","ECP","mapi","OWA","OAB","PowerShell","WebServices")
		If ($ExOrgCfg.MapiHTTPEnabled)
		{Write-Host -ForegroundColor Green "MAPI HTTP Enabled, please verify MAPI VirtualDirectory settings"}
	}
	else
	{
		$vdirs = @("Activesync","ECP","OWA","OAB","PowerShell","WebServices")
	}
	}
else
	{
		$vdirs = @("Activesync","ECP","OWA","OAB","PowerShell","WebServices")
	}
foreach ($i in $vdirs) {
	$cmd = "Get-"+$i+"VirtualDirectory"+" | fl name,server,internalurl,externalurl,*AuthenticationMethods"
invoke-expression $cmd
}
Get-ClientAccessServer | fl name,AutoDiscoverServiceInternalUri
Get-OutlookAnywhere | fl ServerName,SSLOffloading,*hostname,*AuthenticationMethod
