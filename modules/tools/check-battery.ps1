# check-battery.ps1


<#
 Ce script permet de vérifier l'état de la batterie d'un système Windows via WMI (Windows Management Instrumentation).
 Il récupère des informations telles que le niveau de charge, la tension, le statut de la batterie, et le temps restant estimé.
 L'utilisateur a également la possibilité de générer un rapport détaillé sur l'état de la batterie et de le sauvegarder automatiquement sur le bureau.

 Fonctionnalités :
   - Récupération des informations de la batterie via la classe WMI `Win32_Battery`.
   - Affichage de l'état actuel de la batterie, y compris le niveau de charge, la tension, et le temps restant estimé.
   - Proposition à l'utilisateur de générer un rapport détaillé de la batterie.
   - Si l'utilisateur accepte, le rapport est généré et enregistré automatiquement sur le bureau, avec un horodatage dans le nom du fichier.
   - Le rapport est ouvert immédiatement après sa génération.

 Utilisation :
   - Ce script est principalement utilisé pour obtenir un aperçu rapide et détaillé de l'état de la batterie d'un ordinateur portable.
   - Le rapport détaillé est généré à l'aide de la commande `powercfg /batteryreport`, qui produit un fichier HTML contenant des informations détaillées sur la batterie.

 Exemples de sortie :
   - Niveau de charge actuel : 75%
   - Temps restant estimé : 120 minutes
   - Rapport généré avec succès : C:\Users\[NomUtilisateur]\Desktop\battery-report-2025-05-08_14-30-45.html

 Avertissements :
   - Ce script ne fonctionne que sur des systèmes disposant d'une batterie (environnements de PC fixes sans batterie ne sont pas pris en charge).
#>


# Chargement des composants
. "$PSScriptRoot\modules\shared\encodeUTF8.ps1"


Clear-Host
Write-Host "🔋 Vérification de l'état de la batterie en cours..."
Start-Sleep -Milliseconds 800

# Récupération des informations de batterie via WMI
$battery = Get-WmiObject -Class Win32_Battery

if (-not $battery) {
    Write-Host "❌ Aucune batterie détectée. Ce système semble être un PC fixe, ou votre ordinateur portable est connecté directement à l'alimentation sans utiliser de batterie" -ForegroundColor Red
    Write-Host "`n↩️  Retour au menu principal..." 
    Start-Sleep -Seconds 3

} else {
    foreach ($b in $battery) {
        $status = switch ($b.BatteryStatus) {
            1 {"🔌 Déchargée"}
            2 {"⚡ En charge"}
            3 {"🔋 Complètement chargée"}
            4 {"⚠️ Faible"}
            5 {"⚠️ Critique"}
            6 {"🔌 En charge"}
            7 {"⚠️ En panne"}
            8 {"🔄 Inconnue"}
            9 {"🔄 En charge"}
            10 {"⏳ En attente"}
            11 {"🔄 Inconnu"}
            default {"❔ Indéterminé"}
        }

        Write-Host ""
        Write-Host "État de la batterie : $status" -ForegroundColor Yellow
        Write-Host "Niveau de charge actuel : $($b.EstimatedChargeRemaining)%" -ForegroundColor Green
        Write-Host "Tension : $($b.DesignVoltage) mV" -ForegroundColor Gray
        Write-Host "Temps restant estimé : $($b.EstimatedRunTime) minutes" -ForegroundColor Gray
    }

 # Proposer la génération du rapport détaillé
 Write-Host ""
 $choice = Read-Host "📝 Souhaitez-vous générer un rapport détaillé de la batterie ? (o/n)"

 if ($choice.ToLower() -eq "o") {
     $desktop = [Environment]::GetFolderPath("Desktop")
     $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
     $reportPath = Join-Path $desktop "battery-report-$timestamp.html"

     try {
         powercfg /batteryreport /output "$reportPath" | Out-Null
         Write-Host "`n✅ Rapport généré avec succès : $reportPath" -ForegroundColor Green
         Start-Sleep -Seconds 1
         Start-Process "$reportPath"
     } catch {
         Write-Host "`n❌ Échec lors de la génération du rapport." -ForegroundColor Red
     }
 } else {
    Write-Host "`nAppuyez sur une touche pour revenir au menu..." -ForegroundColor DarkGray
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    return
 }
}