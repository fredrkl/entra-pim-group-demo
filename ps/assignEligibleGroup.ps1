Import-Module Microsoft.Graph.Identity.SignIns

# Assign a group to `Eligibility` role for PIM Group
$teamabcpim = "ab41503f-3eaa-45bb-8876-59a8c344d762" # team-abc-pim
$teamabc = "5c4f1e8b-2d6e-4c72-abf8-5ab15c32a326" # team-abc
$startTime = Get-Date
$endTime = $startTime.AddMonths(12).AddDays(-1)

$params = @{
  groupId = $teamabcpim
  principalId = $teamabc
  accessId = "member"
  principalType = "Group"
  action = "AdminAssign"
  scheduleInfo     = @{
    startDateTime  = $startTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    expiration     = @{
      type = "noExpiration"
    }
  }
  justification = "Entra ID - PIM Group Assignment"
}

New-MgIdentityGovernancePrivilegedAccessGroupEligibilityScheduleRequest -BodyParameter $params
