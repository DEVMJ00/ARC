Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === FENÊTRE PRINCIPALE ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "Projet ARC - Menu Principal"
$form.Size = New-Object System.Drawing.Size(1000, 600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
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
$labelHeader.Location = New-Object System.Drawing.Point(20, 15)
$headerPanel.Controls.Add($labelHeader)

# Date et heure à droite
$labelDateTime = New-Object System.Windows.Forms.Label
$labelDateTime.ForeColor = "White"
$labelDateTime.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$labelDateTime.AutoSize = $true
$labelDateTime.Location = New-Object System.Drawing.Point(800, 25)
$headerPanel.Controls.Add($labelDateTime)

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $labelDateTime.Text = (Get-Date).ToString("dddd dd MMMM yyyy - HH:mm:ss")
})
$timer.Start()

# === TEXTE INTRO ===
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Choisissez une catégorie :"
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$labelTitle.AutoSize = $true
$form.Controls.Add($labelTitle)
# Centrage horizontal une fois que le label est ajouté au formulaire
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
    $button.Location = New-Object System.Drawing.Point(20, $top)
    $button.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $button.Add_Click($onClick)
    $form.Controls.Add($button)
}

# === BOUTONS ===
Add-MenuButton "1. 📡 Gestion du réseau"        120 { 
    if (Test-Path ".\modules\network\network-menu.ps1") {
        . .\modules\network\network-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module réseau introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "2. Outils système"           170 {
    if (Test-Path ".\modules\system\system-menu.ps1") {
        . .\modules\system\system-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module système introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "3. Reboot et extinction"     220 {
    if (Test-Path ".\modules\reboot\reboot-menu.ps1") {
        . .\modules\reboot\reboot-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module reboot introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "4. Mise à jour système"      270 {
    if (Test-Path ".\modules\update\update-menu.ps1") {
        . .\modules\update\update-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module de mise à jour introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "5. Outils supplémentaires"   320 {
    if (Test-Path ".\modules\tools\tools-menu.ps1") {
        . .\modules\tools\tools-menu.ps1
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module outils introuvable.","Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
}

Add-MenuButton "6. Quitter"                  370 {
    $form.Close()
}

# === AFFICHAGE ===
[void]$form.ShowDialog()
