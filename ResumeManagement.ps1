$servers = Get-Content resumeServers.txt

.\initPacli.ps1 -Environment Prod -Safe RJ_Server_Local_Admin
.\Pacli.exe OPENSAFE | Out-Null

ForEach ($server in $servers) {
	Write-Host $server
	$comp = $comp = Get-ADComputer $server.Substring(0, ($server.IndexOf('.')))
	$SID = $comp.SID.Value
	.\Pacli.exe DELETEFILECATEGORY FILE=`"$SID`" CATEGORY=`"CPMDisabled`" | Out-Null
	.\Pacli.exe DELETEFILECATEGORY FILE=`"$SID`" CATEGORY=`"LastFailDate`" | Out-Null
}

.\Pacli.exe CLOSESAFE | Out-Null
.\termPacli.ps1