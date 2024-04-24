Import-Module Microsoft.Graph.Identity.SignIns

# All the rules are defined her: https://learn.microsoft.com/en-us/graph/api/policyroot-list-rolemanagementpolicies?view=graph-rest-1.0&tabs=powershell
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
      },
      @{
        "@odata.type" = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule"
        id = "Expiration_EndUser_Assignment"
        isExpirationRequired = $true
        maximumDuration = "PT2H"
        target = @{
          caller = "EndUser"
          operations = @("All")
          level = "Assignment"
          inheritableSettings = @()
          enforcedSettings = @()
        }
      }
  )
}

$policies = Get-MgPolicyRoleManagementPolicyAssignment -Filter "scopeId eq 'c5df26ef-bb43-406d-92f5-09dc0d7ebef6' and scopeType eq 'Group' and roleDefinitionId eq 'owner'"

# Then update the policy with the new rule
Update-MgPolicyRoleManagementPolicy -UnifiedRoleManagementPolicyId $policies.PolicyId -BodyParameter $params
