# modules/system/show-info.ps1


<#  
    .SYNOPSIS
    Affiche des informations système sous Windows avec un tri visuel par catégorie.

    .DESCRIPTION
    Ce script exécute la commande `systeminfo`, filtre certaines lignes non pertinentes (correctifs, domaine, serveur, etc.),
    et applique une mise en couleur conditionnelle aux informations jugées importantes (nom de l’hôte, processeur, etc.).
    Les lignes contenant des KB de mise à jour sont ignorées.

    .REGEX 
        ^\[\d+\] :
        ^ : début de ligne
        \[ et \] : crochets littéraux
        \d+ : un ou plusieurs chiffres
        Cela correspond à une ligne comme [01] ou [10]
        
        ^\s*\[\d+\] :
        ^\s* : zéro ou plusieurs espaces en début de ligne
        \[\d+\] : même motif que ci-dessus



    .NOTES
    Auteur  : [DEVMJ]
    Version : 1.0
    Date    : 2025-05-08
#>


# Chargement des composants
. "$PSScriptRoot\..\shared\encodeUTF8.ps1"

Clear-Host
Write-Host "⏱ Chargement des informations systèmes..."
Start-Sleep -Milliseconds 800
Write-Host ""

# Exécution de systeminfo et coloration conditionnelle
systeminfo | ForEach-Object {
    $line = $_

    if (
        $line -like "Correctif(s)*" -or                         # Ignore les en-têtes de la section des correctifs
        $line -like "Serveur d’ouverture de session*" -or       # Ignore les infos réseau locales
        $line -like "Domaine*" -or                              # Ignore le domaine de l'ordinateur
        $line -like "Emplacements des fichiers d’échange*" -or  # Ignore les chemins de fichiers d'échange
        ($line.Trim() -match "^\[\d+\]") -or                    # Ignore les lignes de correctifs formatées comme [01]: ...
        ($line -match "^\s*\[\d+\]") -or                        # Variante avec indentation (ex. espaces avant [01])
        ($line.Trim() -eq "")                                   # Ignore les lignes vides
    ) {
        # Ne rien faire, on passe à la ligne suivante
    }

    elseif (
        $line -like "Processeur*" -or
        $line -like "Mémoire physique totale*" 
    ) {
        # Mise en valeur des performances matérielles
        Write-Host $line -ForegroundColor Green
    }

    elseif (
        $line -like "Nom de l’hôte*" -or 
        $line -like "Nom du système*" -or 
        $line -like "Propriétaire*" -or 
        $line -like "Organisation*" 
    ) {
        # Mise en valeur des informations d'identification de la machine
        Write-Host $line -ForegroundColor Yellow
    }

    else {
        Write-Host $line -ForegroundColor White
    }
}

Write-Host "`nAppuyez sur une touche pour revenir au menu..." -ForegroundColor DarkGray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
return