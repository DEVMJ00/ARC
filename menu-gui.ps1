Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$margeDroite = 20
$margeGauche = 120




# === FENÊTRE PRINCIPALE ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "ARC - Menu Principal"
$form.Size = New-Object System.Drawing.Size(1000, 600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "Fixed3D"
$form.MaximizeBox = $true

# Créer une image (logo) dans un PictureBox
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(100, 100) # Taille de l'image
$pictureBox.Location = New-Object System.Drawing.Point(0, 0) # Position à gauche du label
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox.BackColor = [System.Drawing.Color]::Transparent
$pictureBox.Image = [System.Drawing.Image]::FromFile("$PSScriptRoot\modules\shared\logo.png") 

$form.Controls.Add($pictureBox)

# === HEADER GRAPHIQUE ===
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Size = New-Object System.Drawing.Size(400, 100)
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
$labelHeader.Location = New-Object System.Drawing.Point($margeGauche, 35)
# Date et heure à droite
$labelDateTime = New-Object System.Windows.Forms.Label
$labelDateTime.ForeColor = "White"
$labelDateTime.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$labelDateTime.AutoSize = $true
#$labelDateTime.Location = New-Object System.Drawing.Point(700, 25)
$headerPanel.Controls.Add($labelDateTime)


# Position initiale à droite une fois que le label est ajouté au formulaire
$labelDateTime.Location = New-Object System.Drawing.Point(
    [Math]::Max(0, ($headerPanel.ClientSize.Width - $labelDateTime.PreferredWidth) - $margeDroite),
    35
)

# Fonction pour repositionner dynamiquement l'horloge
function Update-DateTimePosition {
    $labelDateTime.Location = New-Object System.Drawing.Point(
        [Math]::Max(0, $headerPanel.ClientSize.Width - $labelDateTime.PreferredWidth - $margeDroite),
        35
    )
}

# Redimensionnement du headerPanel
$headerPanel.Add_Resize({ Update-DateTimePosition })


$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $labelDateTime.Text = (Get-Date).ToString("dddd dd MMMM yyyy - HH:mm:ss")
    Update-DateTimePosition
})
$timer.Start()



# === TEXTE MENU ===
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Choisissez une catégorie :"
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$labelTitle.AutoSize = $true
$form.Controls.Add($labelTitle)
$labelTitle.Location = New-Object System.Drawing.Point(
    [Math]::Max(0, ($form.ClientSize.Width - $labelTitle.PreferredWidth) / 2),
    110
)
$form.Add_Resize({
    $labelTitle.Location = New-Object System.Drawing.Point(
        [Math]::Max(0, ($form.ClientSize.Width - $labelTitle.PreferredWidth) / 2),
        110
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
Add-MenuButton "1. Gestion du réseau"        140 { 
    if (Test-Path ".\modules\network\gui\network-menu.ps1") {
        . .\modules\network\gui\network-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module réseau introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "2. Outils système"           190 {
    if (Test-Path ".\modules\system\system-menu.ps1") {
        . .\modules\system\system-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module système introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "3. Reboot et extinction"     240 {
    if (Test-Path ".\modules\reboot\reboot-menu.ps1") {
        . .\modules\reboot\reboot-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module reboot introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "4. Mise à jour système"      290 {
    if (Test-Path ".\modules\update\update-menu.ps1") {
        . .\modules\update\update-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module de mise à jour introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "5. Outils supplémentaires"   340 {
    if (Test-Path ".\modules\tools\tools-menu.ps1") {
        . .\modules\tools\tools-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module outils introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "6. Quitter"                  390 {
    $form.Close()
}

# === AFFICHAGE ===
[void]$form.ShowDialog()
