# clean-temp.ps1

<#
 Ce script permet de nettoyer le dossier TEMP en supprimant tous les fichiers présents dans celui-ci.
 Il parcourt récursivement les fichiers du dossier TEMP et les supprime s'ils existent.
 Si aucun fichier n'est trouvé, un message d'information est affiché. 
 Si des erreurs surviennent pendant la suppression, un message d'erreur est affiché.

 Fonctionnalités :
   - Accède au dossier TEMP de l'utilisateur via la variable d'environnement `$env:TEMP`.
   - Récupère tous les fichiers du dossier TEMP et les supprime.
   - Affiche un message de confirmation ou d'erreur, selon les résultats de l'opération.
   - Attente de l'interaction de l'utilisateur pour revenir au menu principal.
#>


# Chargement des composants
. "$PSScriptRoot\modules\shared\encodeUTF8.ps1"


Clear-Host
Write-Host "🧹 Nettoyage du dossier TEMP en cours..." -ForegroundColor Cyan
Start-Sleep -Milliseconds 800

# Définition du chemin du dossier TEMP et récupération des fichiers à l'intérieur
$tempPath = $env:TEMP
$files = Get-ChildItem -Path $tempPath -Recurse -File -ErrorAction SilentlyContinue
$count = $files.Count

# Vérification du nombre de fichiers à supprimer
if ($count -eq 0) {
    Write-Host "✅ Aucun fichier à supprimer dans $tempPath" -ForegroundColor Yellow
    } else {
        try {
            $files | Remove-Item -Force -ErrorAction SilentlyContinue
            Write-Host "✅ $count fichier(s) supprimé(s) du dossier TEMP." -ForegroundColor Green
        } catch {
            Write-Host "❌ Erreur lors de la suppression de certains fichiers." -ForegroundColor Red
        }
    }


Write-Host "`nAppuyez sur une touche pour revenir au menu..." -ForegroundColor DarkGray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
return
