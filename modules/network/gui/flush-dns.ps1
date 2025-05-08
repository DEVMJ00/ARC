# Chargement des composants nécessaires pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Fonction pour exécuter la commande de vidage du cache DNS
function Flush-DNS {
    $ipconfigResult = ipconfig /flushdns 2>&1
    return $ipconfigResult
}

# Créer la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Vidage du cache DNS"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Créer un label pour afficher les messages
$labelMessage = New-Object System.Windows.Forms.Label
$labelMessage.Text = "Préparation à vider le cache DNS..."
$labelMessage.Size = New-Object System.Drawing.Size(350, 40)
$labelMessage.Location = New-Object System.Drawing.Point(25, 30)
$labelMessage.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($labelMessage)

# Créer un bouton pour lancer l'action de vidage du cache DNS
$buttonFlush = New-Object System.Windows.Forms.Button
$buttonFlush.Text = "Vider le cache DNS"
$buttonFlush.Size = New-Object System.Drawing.Size(160, 40)
$buttonFlush.Location = New-Object System.Drawing.Point(120, 80)
$buttonFlush.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($buttonFlush)

# Créer un bouton pour fermer la fenêtre après l'opération
$buttonClose = New-Object System.Windows.Forms.Button
$buttonClose.Text = "Retour au menu"
$buttonClose.Size = New-Object System.Drawing.Size(160, 40)
$buttonClose.Location = New-Object System.Drawing.Point(120, 120)
$buttonClose.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$buttonClose.Enabled = $false # Le bouton sera désactivé jusqu'à la fin de l'opération
$form.Controls.Add($buttonClose)

# Fonction à appeler lors du clic sur le bouton "Vider le cache DNS"
$buttonFlush.Add_Click({
    $labelMessage.Text = "Vidage du cache DNS en cours..."
    $buttonFlush.Enabled = $false  # Désactiver le bouton pendant l'exécution
    
    # Lancer l'exécution de la commande pour vider le cache DNS
    $result = Flush-DNS

    # Afficher le message de succès
    if ($result -match "Successfully flushed the DNS Resolver Cache") {
        $labelMessage.Text = "✅ Cache DNS vidé avec succès !"
    } else {
        $labelMessage.Text = "❌ Erreur lors du vidage du cache DNS."
    }

    # Activer le bouton de retour
    $buttonClose.Enabled = $true
})

# Fonction à appeler lors du clic sur le bouton "Retour au menu"
$buttonClose.Add_Click({
    $form.Close()
})

# Afficher le formulaire
$form.ShowDialog()
