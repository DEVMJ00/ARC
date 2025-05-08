#menu-console.ps1


# Chargement des composants
. "$PSScriptRoot\modules\shared\console\encodeUTF8.ps1"
. "$PSScriptRoot\modules\shared\console\header.ps1"

# raccourcis clavier pour comment/uncomment : Ctrl+K & Ctrl+C    et     Ctrl+K & Ctrl+U


Clear-Host
Show-Header

# Fonction pour afficher le menu principal
function Show-Menu {
    Write-Host "1.	Gestion du réseau" -ForegroundColor Green
    Write-Host "2.	Outils système" -ForegroundColor Green
    Write-Host "3.	Reboot et extinction" -ForegroundColor Green
    Write-Host "4.	Mise à jour du système" -ForegroundColor Green
    Write-Host "5.	Divers (outils supplémentaires)" -ForegroundColor Green
    Write-Host "6.	Quitter" -ForeGroundColor Yellow
   
}

# Fonction principale
function Start-ARC {
    # Show-Loading
    while ($true) {
        Show-Menu
		Write-Host ""
        $choice = Read-Host "Choisissez une catégorie (1-6)"

        switch ($choice) {
    
            1 { if (Test-Path ".\modules\network\console\network-menu.ps1") {
            .\modules\network\console\network-menu.ps1
                } else {
                    Write-Host "Module réseau introuvable." -ForegroundColor Red
                    Start-Sleep -Seconds 3
                    Clear-Host
                    Show-Header
                }
	        }
    
            2 { if (Test-Path ".\modules\system\console\system-menu.ps1") {
            .\modules\system\console\system-menu.ps1 
                } else {
                    Write-Host "Module Système introuvable." -ForegroundColor Red
                    Start-Sleep -Seconds 3
                    Clear-Host
                    Show-Header
                }
            }

            3 { if (Test-Path ".\modules\reboot\console\reboot-menu.ps1") {
            .\modules\reboot\console\reboot-menu.ps1
                } else {
                    Write-Host "Module de Redémarrage introuvable." -ForeGroundColor Red
                    Start-Sleep -Seconds 3
                    Clear-Host
                    Show-Header
                }
            }
    
            4 { if (Test-path ".\modules\update\console\update-menu.ps1") {
            .\modules\update\console\update-menu.ps1
                } else {
                    Write-Host "Module de Mises à Jour introuvable." -ForeGroundColor Red
                    Start-Sleep -Seconds 3
                    Clear-Host
                    Show-Header
                }
            }

            5 { if (Test-path ".\modules\tools\console\tools-menu.ps1") {
            .\modules\tools\console\tools-menu.ps1
                } else {
                    Write-Host "Module Outils introuvable." -ForeGroundColor Red
                    Start-Sleep -Seconds 3
                    Clear-Host
                    Show-Header
                }   
            }

            6 { Write-Host "Fermeture du Projet ARC... À bientôt !" -ForegroundColor Green; exit }
            
            default { Write-Host "Choix invalide. Veuillez recommencer." -ForegroundColor Red; Start-Sleep -Seconds 3; }
        }
    }
}

# Lancement du script
Start-ARC


