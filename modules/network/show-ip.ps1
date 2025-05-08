# show-ip.ps1

<#
 Ce script affiche l'adresse IP actuelle de l'ordinateur, en se concentrant sur les adresses IPv4 valides 
 et en excluant les adresses d'origine "WellKnown" (souvent utilisées par des interfaces réseau système).
 Le script affiche l'adresse IP et attend une interaction de l'utilisateur pour revenir au menu précédent.

 Composants :
   - Affichage de l'adresse IP via Get-NetIPAddress.
   - Filtrage des résultats pour obtenir uniquement les adresses IPv4 valides.
   - Formatage et affichage dans un tableau avec auto-ajustement des colonnes.

 Fonctionnalités :
   - Affiche l'adresse IP actuelle en IPv4.
   - Attente de l'interaction de l'utilisateur pour revenir au menu principal.
#>


# Chargement des composants
. "$PSScriptRoot\..\shared\encodeUTF8.ps1"

Clear-Host
Write-Host "Votre adresse IP actuelle : " -ForegroundColor Cyan

# Récupère les adresses IPv4 non "WellKnown" et les affiche dans un format de table
Get-NetIPAddress | 
    Where-Object {$_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -ne "WellKnown"} | 
    Select-Object IPAddress |
    Format-Table -AutoSize

Write-Host "`nAppuyez sur une touche pour revenir au menu précédent..." -ForegroundColor DarkGray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
return