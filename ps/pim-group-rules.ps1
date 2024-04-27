param (
  [Parameter(Mandatory = $True)]
  [string]$GroupId,
  [Parameter(Mandatory = $True)]
  [string]$Role
)

Import-Module Microsoft.Graph.Identity.SignIns

# All the rules are defined her: https://learn.microsoft.com/en-us/graph/api/policyroot-list-rolemanagementpolicies?view=graph-rest-1.0&tabs=powershell
$params = @{
  rules = @(
      @{
        "@odata.type" = "#microsoft.graph.unifiedRoleManagementPolicyApprovalRule"
        id = "Approval_EndUser_Assignment"
        target = @{
          caller = "EndUser"
          operations = @("All")
          level = "Assignment"
          inheritableSettings = @()
          enforcedSettings = @()
        }
        setting = @{
          isApprovalRequired = $true
          isApprovalRequiredForExtension = $false
          isRequestorJustificationRequired = $true
          approvalMode = "SingleStage"
          approvalStages = @(
            @{
              isApproverJustificationRequired = $true
              isEscalationEnabled = $false
              primaryApprovers = @(
                @{
                  "@odata.type" = "#microsoft.graph.groupMembers"
                  isBackup = $false
                  id = "1cf624d0-4cf2-458a-83b8-3d2687d248d5" # aks-prod-owners
                  description = $null
                })
              escalationApprovers = @()
            })
        }
      },
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
        maximumDuration = "PT3H"
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
Write-Host "Creating PIM policy for group $GroupId"

$policies = Get-MgPolicyRoleManagementPolicyAssignment -Filter "scopeId eq '$GroupId' and scopeType eq 'Group' and roleDefinitionId eq '$Role'"

#### Debugging
#$policy = Get-MgPolicyRoleManagementPolicy -UnifiedRoleManagementPolicyId $policies.PolicyId -ExpandProperty "rules(`$select=id)"
#$json = $policy | ConvertTo-Json -Depth 10
#Write-Host "Policy: $json"
##foreach ($policy in $policies) {
##  $json = $policy | ConvertTo-Json -Depth 10
##  Write-Host "Policy: $json"
##}

### Debugging

Update-MgPolicyRoleManagementPolicy -UnifiedRoleManagementPolicyId $policies.PolicyId -BodyParameter $params

# Usage:
# ./pim-group-rules.ps1 -GroupId c5df26ef-bb43-406d-92f5-09dc0d7ebef6 -Role owner
