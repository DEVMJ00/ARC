# check-admin.ps1

<#
 Ce script permet de vérifier si l'utilisateur actuel dispose des droits administrateur sur la machine.
 Si l'utilisateur est administrateur, le script continue son exécution normalement.
 Si l'utilisateur n'est pas administrateur, un message est affiché et l'utilisateur est invité à relancer le script avec les privilèges administrateur.
 Le script revient ensuite au menu principal ou précédent après que l'utilisateur ait appuyé sur une touche.

 Fonctions incluses :
   - Test-AdminRights : Vérifie si l'utilisateur actuel a les droits administrateurs.
   - Assert-AdminOrExit : Vérifie si l'utilisateur a les droits administrateurs et agit en conséquence.
     Si l'utilisateur n'est pas administrateur, il lui est demandé de relancer PowerShell en mode administrateur.
     En cas d'erreur ou si l'utilisateur n'est pas administrateur, le script revient au menu principal.
#>

function Test-AdminRights {
<#
    .SYNOPSIS
    Vérifie si l'utilisateur actuel est un administrateur.

    .DESCRIPTION
    Cette fonction vérifie si l'utilisateur actuel fait partie du groupe des administrateurs locaux. 
    Elle renvoie $true si l'utilisateur a les droits administratifs, sinon $false.

    .OUTPUTS
    $true si l'utilisateur est administrateur, sinon $false.
#>

    $isAdmin = ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole]::Administrator)

    return $isAdmin
}

function Assert-AdminOrExit {
<#
    .SYNOPSIS
    Vérifie si l'utilisateur est administrateur et gère le flux en conséquence.

    .DESCRIPTION
    Cette fonction appelle la fonction Test-AdminRights pour vérifier si l'utilisateur est administrateur.
    Si l'utilisateur n'est pas administrateur, un message est affiché, l'utilisateur est informé de la nécessité d'exécuter PowerShell en mode administrateur,
    et il peut appuyer sur une touche pour revenir au menu précédent.

    .OUTPUTS
    $true si l'utilisateur est administrateur, sinon $false. Si l'utilisateur n'est pas administrateur, il est renvoyé au menu principal.
#>

    if (-not (Test-AdminRights)) {
        Write-Host "`n❌ Ce script nécessite les droits administrateur." -ForegroundColor Red
        Write-Host "Veuillez relancer PowerShell en tant qu'administrateur." -ForegroundColor Yellow
        Start-Sleep -Seconds 3

        try {
            Write-Host "`nAppuyez sur une touche pour revenir au menu précédent..." -ForegroundColor DarkGray
           $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
         } catch {
            Read-Host "`nAppuyez sur Entrée pour revenir au menu"
            . "$PSScriptRoot\..\..\menu-console.ps1" ;
     }
        return $false
    }
    return $true
}
