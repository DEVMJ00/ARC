# header.ps1


# Fonction pour afficher le Header
function Show-Header {
    # Clear-Host
    $time = Get-Date -Format "HH:mm:ss"
    $date = Get-Date -Format "dddd dd MMMM yyyy"
    $bar = "=" * 45

    Write-Host $bar -ForegroundColor Cyan
    Write-Host "        .o.       ooooooooo.     .oooooo.   "
    Write-Host "       .888.       888    Y88.  d8P    Y8b  "
    Write-Host "      .8 888.      888   .d88  888          "
    Write-Host "     .8   888.     888ooo88P   888          "
    Write-Host "    .88ooo8888.    888 88b.    888          "
    Write-Host "   .8       888.   888   88b.   88b    ooo  "
    Write-Host "  o88o     o8888o o888o  o888o   88bood8P   "
    Write-Host ""
    Write-Host "  🛠️  (Administrate, Restore & Configure)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host ("📅  $date").PadLeft(30)
    Write-Host ("⏰  $time").PadLeft(25)
    Write-Host $bar -ForegroundColor Cyan
    Write-Host ""
}
