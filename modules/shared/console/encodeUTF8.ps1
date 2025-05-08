# encoreUTF8.ps1


<#
 Ce script permet de forcer l'encodage UTF-8 pour l'affichage dans la console PowerShell, afin d'assurer la bonne gestion des caractères spéciaux
 lors de l'exécution de scripts PowerShell, notamment pour les systèmes où l'encodage par défaut pourrait ne pas être UTF-8.

 Fonctionnalités :
   - Définit l'encodage de sortie PowerShell sur UTF-8 pour s'assurer que les caractères spéciaux s'affichent correctement.
   - Modifie l'encodage de la console Windows pour utiliser UTF-8.
   - Utilise la commande `chcp 65001` pour changer le code page de la console en UTF-8, ce qui est nécessaire pour certains systèmes
     afin de gérer les caractères non-ASCII.
#>

# Force l'UTF-8 pour l'affichage
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null