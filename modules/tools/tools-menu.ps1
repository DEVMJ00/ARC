# tools-menu.ps1

# Chargement des composants
. "$PSScriptRoot\modules\shared\encodeUTF8.ps1"


while ($true) {
    Clear-Host
    Write-Host "==== Divers - Outils supplémentaires ====" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Nettoyer le dossier ""temp"" "
    Write-Host "2. Vérifier l'état de la batterie" 
    Write-Host "3. Retour au menu principal "
    Write-Host ""

    $userChoice = Read-Host "Choisissez une action (1-3)"

    switch ($userChoice) {
        "1" {
            if (Test-Path ".\modules\tools\clean-temp.ps1") {
                . "$PSScriptRoot\clean-temp.ps1"
            } else {
                Write-Host "Module de suppression des fichiers temporaires introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
                }
            }
          
        "2" {
            if (Test-Path "$PSScriptRoot\check-battery.ps1") {
               . "$PSScriptRoot\check-battery.ps1"
            } else {
                Write-Host "Module de Vérification de la batterie introuvable." -ForeGroundColor Red
                Start-Sleep -Seconds 3
            }         

        }

        "3" {
                Clear-Host
                Show-Header
                return 
            }
        default {
            Write-Host "Choix invalide. Veuillez réessayer." -ForegroundColor Red
            Start-Sleep -Seconds 3
        }
    }
}