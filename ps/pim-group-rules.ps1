Import-Module Microsoft.Graph.Identity.SignIns

$params = @{
  rules = @(
      @{
        "@odata.type" = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule"
        id = "Expiration_Admin_Eligibility"
        isExpirationRequired = $false
        maximumDuration = "P365D"
        target = @{
          caller = "Admin"
          operations = @("All")
          level = "Eligibility"
          inheritableSettings = @()
          enforcedSettings = @()
        }
      }
  )
}

# Need to find the unifiedRoleManagementPolicyId
#
# Get the policy
$policies = Get-MgPolicyRoleManagementPolicy -Filter "scopeId eq 'c5df26ef-bb43-406d-92f5-09dc0d7ebef6' and scopeType eq 'Group'" -ExpandProperty "rules(`$select=id)"

foreach ($policy in $policies) {
  $json = $policy| ConvertTo-Json -Depth 10
#  Write-Host "Policy is [$policy]"
  Write-Output $json
}


# Write out the policy in json
#Write-Host "Policy is [$policies]"



#$unifiedRoleManagementPolicyId = $policies.value.id
#Write-Host "Policy is $unifiedRoleManagementPolicyId"

#Update-MgPolicyRoleManagementPolicy -UnifiedRoleManagementPolicyId $unifiedRoleManagementPolicyId -BodyParameter $params

#Write-Host "Policies are $policies"
