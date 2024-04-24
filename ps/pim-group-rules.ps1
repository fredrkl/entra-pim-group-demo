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

# After this one I need to filter out the owner only: https://learn.microsoft.com/en-us/graph/api/policyroot-list-rolemanagementpolicyassignments?view=graph-rest-1.0&tabs=powershell#example-3-retrieve-details-of-all-role-management-policy-assignments-for-pim-for-groups
#Get-MgPolicyRoleManagementPolicyAssignment -Filter "scopeId eq 'c5df26ef-bb43-406d-92f5-09dc0d7ebef6' and scopeType eq 'Group'"

$policies = Get-MgPolicyRoleManagementPolicyAssignment -Filter "scopeId eq 'c5df26ef-bb43-406d-92f5-09dc0d7ebef6' and scopeType eq 'Group' and roleDefinitionId eq 'owner'" -ExpandProperty "policy(`$expand=rules)"

Write-Output $policies.PolicyId
Write-Output $policies.Id

#foreach ($policy in $policies) {
#  $json = $policy| ConvertTo-Json -Depth 10
#  Write-Output $json
#}

# Now I need to update the policy with the new rule


# Need to find the unifiedRoleManagementPolicyId
#
# Get the policy
#$policies = Get-MgPolicyRoleManagementPolicy -Filter "scopeId eq 'c5df26ef-bb43-406d-92f5-09dc0d7ebef6' and scopeType eq 'Group'" -ExpandProperty "rules(`$select=id)"
#
#foreach ($policy in $policies) {
#  $json = $policy| ConvertTo-Json -Depth 10
##  Write-Host "Policy is [$policy]"
#  Write-Output $json
#
#  $policyId = $policy.Id
#  Write-Host "PolicyId is $policyId"
#  #Write-Host "Rules are $policy.rules"
#  foreach ($rule in $policy.rules) {
#    $jsonRule = $rule| ConvertTo-Json -Depth 10
#    Write-Output $jsonRule
#  }
#}


# Write out the policy in json
#Write-Host "Policy is [$policies]"



#$unifiedRoleManagementPolicyId = $policies.value.id
#Write-Host "Policy is $unifiedRoleManagementPolicyId"

#Update-MgPolicyRoleManagementPolicy -UnifiedRoleManagementPolicyId $unifiedRoleManagementPolicyId -BodyParameter $params

#Write-Host "Policies are $policies"
