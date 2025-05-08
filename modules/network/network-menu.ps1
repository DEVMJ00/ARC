# modules/network/network-menu.ps1

# Chargement des composants
. "$PSScriptRoot\..\shared\encodeUTF8.ps1"
. "$PSScriptRoot\..\shared\header.ps1"




# Boucle de menu réseau
while ($true) {
    # Show-Header
    Clear-Host
    Write-Host "==== Gestion du Réseau ====" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Afficher l'adresse IP"
    Write-Host "2. Rafraîchir la connexion réseau" 
    Write-Host "3. Vider le cache DNS"
    Write-Host "4. Retour au menu principal"
    Write-Host ""

    $userChoice = Read-Host "Choisissez une action réseau (1-4)"

    switch ($userChoice) {
        "1" {
            if (Test-Path "$PSScriptRoot\show-ip.ps1") {
                . "$PSScriptRoot\show-ip.ps1"
            } else {
                Write-Host "Module d'affichage IP introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
            }
        }
        "2" {
            if (Test-Path "$PSScriptRoot\refresh-connection.ps1") {
                . "$PSScriptRoot\refresh-connection.ps1"
                Start-Sleep -Seconds 5
            } else {
                Write-Host "Module de rafraîchissement de connexion introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
            }
        }
        "3" {
            if (Test-Path "$PSScriptRoot\flush-dns.ps1") {
                . "$PSScriptRoot\flush-dns.ps1"
            } else {
                Write-Host "Module de vidage DNS introuvable." -ForegroundColor Red
                Start-Sleep -Seconds 3
            }
        }
        "4" { 
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
