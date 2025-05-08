# flush-dns.ps1

<#
 Ce script permet de vider le cache DNS du système en utilisant la commande `ipconfig /flushdns`.
 Cette action est souvent réalisée pour résoudre des problèmes de connexion réseau liés à des informations DNS obsolètes.
 Une fois l'opération effectuée, un message de succès est affiché.

 Fonctionnalités :
   - Exécution de la commande `ipconfig /flushdns` pour vider le cache DNS.
   - Affichage d'un message de confirmation lorsque l'opération est terminée avec succès.
   - Attente de l'interaction de l'utilisateur pour revenir au menu principal.
#>

# Chargement des composants
. "$PSScriptRoot\..\shared\console\encodeUTF8.ps1"


Clear-Host
Write-Host "Vidage du cache DNS en cours..." -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Vidage du cache DNS
ipconfig /flushdns > $null
# Affichage du message de succès
Write-Host "✅ Cache DNS vidé avec succès !" -ForegroundColor Green


Write-Host "`nAppuyez sur une touche pour revenir au menu précédent..." -ForegroundColor DarkGray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
return
