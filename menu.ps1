#menu.ps1


# Chargement des composants
. "$PSScriptRoot\modules\shared\console\encodeUTF8.ps1"
. "$PSScriptRoot\modules\shared\console\header.ps1"

Clear-Host
Show-Header

Write-Host ""
Write-Host "1. Démarrer en mode console" -ForegroundColor Green
Write-Host "2. Démarrer en mode graphique" -ForegroundColor Green
Write-Host ""
Write-Host "3. Quitter" -ForegroundColor Yellow
Write-Host ""

while ($true) {
    Write-Host ""
    $choice = Read-Host "Que voulez-vous faire ? (1-3)"

    switch ($choice) {
    
        1 { if (Test-Path ".\menu-console.ps1") {
            .\menu-console.ps1
            } else {
                Write-Host "Le mode console est introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
                Clear-Host
                Show-Header
            }
        }

        2 { if (Test-Path ".\menu-gui.ps1") {
            .\menu-gui.ps1
            } else {
                Write-Host "Le mode graphique est introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
                Clear-Host
                Show-Header
            }
        }

        3 { Write-Host "Fermeture du Projet ARC... À bientôt !" -ForegroundColor Green; exit }
         
        default { Write-Host "Choix invalide. Veuillez recommencer." -ForegroundColor Red; Start-Sleep -Seconds 3; }
    }
}