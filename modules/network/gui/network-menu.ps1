# modules>network>gui>network-menu.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$margeDroite = 20
$margeGauche = 20


# === FENÊTRE PRINCIPALE ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "ARC - Gestion du réseau"
$form.Size = New-Object System.Drawing.Size(1000, 600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "Fixed3D"
$form.MaximizeBox = $true

# === HEADER GRAPHIQUE ===
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Size = New-Object System.Drawing.Size(400, 80)
$headerPanel.BackColor = [System.Drawing.Color]::FromArgb(30, 60, 90)
$headerPanel.Dock = "Top"
$form.Controls.Add($headerPanel)

# Titre du projet
$labelHeader = New-Object System.Windows.Forms.Label
$labelHeader.Text = "ARC : Administrate, Restore and Configure"
$labelHeader.ForeColor = "White"
$labelHeader.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$labelHeader.AutoSize = $true
$headerPanel.Controls.Add($labelHeader)
$labelHeader.Location = New-Object System.Drawing.Point($margeGauche, 20)

# === TEXTE MENU ===
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Choisissez une option :"
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$labelTitle.AutoSize = $true
$form.Controls.Add($labelTitle)
$labelTitle.Location = New-Object System.Drawing.Point(
    [Math]::Max(0, ($form.ClientSize.Width - $labelTitle.PreferredWidth) / 2),
    90
)
$form.Add_Resize({
    $labelTitle.Location = New-Object System.Drawing.Point(
        [Math]::Max(0, ($form.ClientSize.Width - $labelTitle.PreferredWidth) / 2),
        90
    )
})

# === FONCTION DE BOUTON ===
function Add-MenuButton($text, $top, $onClick) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size(340, 40)
    $button.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $button.Add_Click($onClick)
    $form.Controls.Add($button)
    $button.Tag = $top  # Enregistrer la position verticale de chaque bouton


     # Centrer le bouton à l'initialisation
     $button.Location = New-Object System.Drawing.Point(
        [Math]::Max(0, ($form.ClientSize.Width - $button.Size.Width) / 2), $top
    )


    # Recalculer la position des boutons lorsque la fenêtre est redimensionnée
    $form.Add_Resize({
        $form.Controls | ForEach-Object {
            if ($_ -is [System.Windows.Forms.Button]) {
                # Récupérer la position verticale enregistrée pour chaque bouton
                $top = $_.Tag
                # Recentrer le bouton horizontalement
                $_.Location = New-Object System.Drawing.Point(
                    [Math]::Max(0, ($form.ClientSize.Width - $_.Size.Width) / 2), $top
                )
            }
        }
    })
}

# === BOUTONS ===
Add-MenuButton "1. Effacer le cache DNS"        120 { 
    if (Test-Path ".\modules\network\gui\flush-dns.ps1") {
        . .\modules\network\gui\flush-dns.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module de réinitialisation DNS introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

# === AFFICHAGE ===
[void]$form.ShowDialog()