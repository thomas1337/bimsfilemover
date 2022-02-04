# Move Filter Scripts für gewisse Ordner:

Starten über run.bat.
Die run.bat startet das script.ps1 lediglich im Hintergrund und bleibt unsichtbar.

Öffne das Script mal in einem Editor (Notepad++) und ändere die Werte hinter $from und $to auf deine Ordner Pfade.

Um das Script bei jedem Boot mitzustarten, kopiere run.bat und script.ps1 nach:
C:\Users\<user_name>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
(Das habe ich nicht getestet, müsste aber klappen)
Angeblich reicht es auch eine Verknüpfung auf run.bat dort abzulegen.
Siehe https://jd-bots.com/2021/05/15/how-to-run-powershell-script-on-windows-startup/

Das Script selbst scannt bei Start kurz über den $from Ordner ob es irgendwelche Dateien findet worauf der Filter passt (zb alle mit "Rechnung" im Namen) und verschiebt sie. 
Danach horscht es eigentlich nur noch auf Änderungen am Ordner, was sehr effizient ist.

Du kannst im Script auch Logging aktivieren, da ist eine Stelle wo ich was dazu kommentiert hatte.
Auch der Starttooltip lässt sich abschalten.

Beenden lässt es sich wohl nur über den Taskmanager. Du musst nach "Powershell" suchen und alle Prozesse beenden.

Sollte es mal rumbuggen, rechtsklick auf script.ps1 und "Mit Powershell ausführen". Das gibt eine Konsole worin ein paar Infos stehen.

