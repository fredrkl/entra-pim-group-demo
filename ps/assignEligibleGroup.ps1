Import-Module Microsoft.Graph.Identity.SignIns

# Assign a group to `Eligibility` role for PIM Group
$teamDemo = "1bef0223-af48-4cee-bd94-afb428f7259e" # team-demo
$aksprodgroupdemo = "c5df26ef-bb43-406d-92f5-09dc0d7ebef6" # aks-prod-group-demo
$startTime = Get-Date
$endTime = $startTime.AddMonths(12).AddDays(-1)

$params = @{
  groupId = $teamDemo
  principalId = $aksprodgroupdemo
  accessId = "member"
  principalType = "Group"
  action = "AdminAssign"
  scheduleInfo    = @{
    startDateTime  = $startTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    expiration    = @{
                    type = "AfterDateTime"
                    endDateTime = $endTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
                  }
  }
  justification = "Entra ID - PIM Group Assignment"
}

New-MgIdentityGovernancePrivilegedAccessGroupEligibilityScheduleRequest -BodyParameter $params
