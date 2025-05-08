# show-info.ps1


<#
    .SYNOPSIS
        Affiche les informations système Windows dans une interface graphique (GUI).

    .DESCRIPTION
        La fonction Show-SystemInfoGUI utilise les bibliothèques .NET Windows Forms pour afficher
        une fenêtre contenant les informations système retournées par la commande `systeminfo`.

        Les informations sont affichées dans une ListBox avec une police monospace pour une meilleure lisibilité.
        Certaines lignes sont volontairement filtrées pour éviter les informations trop techniques
        ou redondantes (correctifs, domaine, etc.).

        Un bouton "Fermer" permet de quitter la fenêtre proprement.
#>

function Show-SystemInfoGUI {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Informations Système"
    $form.Size = New-Object System.Drawing.Size(700,500)
    $form.StartPosition = "CenterScreen"

    # Liste de sortie
    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Size = New-Object System.Drawing.Size(660,400)
    $listBox.Location = New-Object System.Drawing.Point(10,10)
    $listBox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $form.Controls.Add($listBox)

    # Bouton Fermer
    $buttonClose = New-Object System.Windows.Forms.Button
    $buttonClose.Text = "Fermer"
    $buttonClose.Location = New-Object System.Drawing.Point(300, 420)
    $buttonClose.Add_Click({ $form.Close() })
    $form.Controls.Add($buttonClose)

    # Filtrage des lignes (comme dans le script console)
    systeminfo | ForEach-Object {
        $line = $_.Trim()
        if (
            $line -like "Correctif(s)*" -or
            $line -like "Serveur d’ouverture de session*" -or
            $line -like "Domaine*" -or
            $line -like "Emplacements des fichiers d’échange*" -or
            $line -match "^\[\d+\]" -or
            $line -eq ""
        ) {
            return
        }

        $listBox.Items.Add($line)
    }

    $form.ShowDialog()
}
