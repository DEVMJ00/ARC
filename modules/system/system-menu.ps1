# modules/system/system-menu.ps1

# Chargement des composants
. "$PSScriptRoot\..\shared\encodeUTF8.ps1"
. "$PSScriptRoot\..\shared\header.ps1"


# Boucle de menu système
while ($true) { 
    Clear-Host
    Write-Host "==== Gestion du Système ====" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Afficher les informations sur votre système"
    Write-Host "2. Retour au menu principal"
    Write-Host ""

    $userChoice = Read-Host "Choisissez une action système (1-2)"

    switch ($userChoice) {
        "1" {
            if (Test-Path "$PSScriptRoot\show-info.ps1") {
                . "$PSScriptRoot\show-info.ps1"
            } else {
                Write-Host "Module d'affichage des informations systèmes introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
            }
        }
        
        "2" { 
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



