# refresh-connection.ps1

<#
 Ce script permet de rafraîchir la connexion réseau de l'ordinateur en désactivant puis réactivant la première interface réseau active.
 Il vérifie également si l'utilisateur dispose des droits administrateur nécessaires pour effectuer cette opération.
 Si l'utilisateur n'est pas administrateur, il est invité à relancer le script avec des droits d'administrateur.

 Fonctionnalités :
   - Vérification des droits administrateur avant d'exécuter le script (fonction `Assert-AdminOrExit`).
   - Identification de la première interface réseau active.
   - Désactivation de l'interface réseau suivie d'une réactivation pour rafraîchir la connexion.
   - Affichage de messages informatifs tout au long du processus.
   - Si aucune interface réseau active n'est détectée, un message d'erreur est affiché.
   - L'utilisateur est invité à appuyer sur une touche pour revenir au menu principal après l'exécution du script.

 Pré-requis :
   - Ce script nécessite les droits administrateur pour désactiver et réactiver les interfaces réseau.

 Exemples d'exécution :
   - Lancer le script dans une fenêtre PowerShell avec des droits administrateur pour rafraîchir la connexion réseau.

 Sortie :
   - Le script affiche un message de succès ou d'échec en fonction du résultat de l'opération.
#>


# Chargement des composants 
. "$PSScriptRoot\..\shared\encodeUTF8.ps1"
. "$PSScriptRoot\..\shared\check-admin.ps1"
if (-not (Assert-AdminOrExit)) {
    return
}


# Clear-Host
Write-Host "🔄 Rafraîchissement automatique de la connexion réseau" -ForegroundColor Cyan
Write-Host ""

# Récupère la première interface active (statut Up)
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

if ($adapter) {
    Write-Host "Interface détectée : $($adapter.Name)" -ForegroundColor Yellow
    Write-Host "`n⛔ Désactivation en cours..."
    Disable-NetAdapter -Name $adapter.Name -Confirm:$false
    Start-Sleep -Seconds 2

    Write-Host "⚡ Réactivation en cours..."
    Enable-NetAdapter -Name $adapter.Name -Confirm:$false
    Start-Sleep -Seconds 2

    Write-Host "`n✅ Connexion réseau rafraîchie avec succès !" -ForegroundColor Green
    Start-Sleep -Seconds 2    
}
    
    else {
            Write-Host "❌ Aucune interface réseau active détectée." -ForegroundColor Red
            Start-Sleep -Seconds 3
    }


    try {
       Write-Host "`nAppuyez sur une touche pour revenir au menu précédent..." -ForegroundColor DarkGray
      $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    } catch {
    Read-Host "Appuyez sur Entrée pour continuer"
}
return