Add-Type -AssemblyName System.Windows.Forms
$host.ui.RawUI.WindowTitle = "BimFileMover" # Plx nicht aendern

### EINSTELLUNGEN @BIM !!!
	$from = "C:\dev\test" # Welchen Ordner scannen?
	$to = "C:\dev\target" # Wohin verschieben?
	$filter = "*Rechnung*.*" # Welche Dateinamen? Die * bedeuten soviel wie "egal was da steht". 
	                         # "*Rechnung*.*" steht fuer irgendeinen Dateiname wo "Rechnung" im Namen vorkommt. Endung ist auch egal.

### SCANNER EINRICHTEN
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $from
    $watcher.Filter = $filter
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true

### EINMAL AUFRAEUMEN BEI START
	Get-ChildItem -Path $from -Filter $filter | Move-Item -Destination $to -Force

### WAS TUN BEI TREFFER
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                #Add-content "C:\dev\log.txt" -value $logline #@bim: raute weg wenn du etwas logging moechtest
				Move-Item -Path $path -Destination $to -Force
              }
### EVENTS ERSTELLEN UND DATEINAMEN AENDERN BEOBACHTEN
    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action
	
### BEI START DIE TOOLTIP MELDUNG ANZEIGEN
	$notify = new-object System.Windows.Forms.NotifyIcon
	$notify.icon = [System.Drawing.SystemIcons]::Information
	$notify.visible = $true

	#@Bim: Vor die naechste Zeile eine Raute setzen wenn die Startup Meldung nervt und wegsoll
	$notify.showballoontip(1,'','Bimchens File Mover ist up!',[System.Windows.Forms.ToolTipIcon]::Info)

### SCRIPT AM LEBEN HALTEN
    while ($true) {
		sleep 5
	}