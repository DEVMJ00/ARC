# ARC (Administrate, Restore & Configure)
Outil PowerShell modulaire pour l'administration de postes Windows.


## Fonctionnalités
- Menu principal interactif
- Modules système, réseau, sécurité, etc.
- Facilement extensible

## Structure
│   menu.ps1
│   README.md
│
└───modules
    ├───network
    │       flush-dns.ps1
    │       network-menu.ps1
    │       refresh-connection.ps1
    │       show-ip.ps1
    │
    ├───reboot
    ├───shared
    │       check-admin.ps1
    │       encodeUTF8.ps1
    │       header.ps1
    │
    ├───system
    ├───tools
    │       clean-temp.ps1
    │       tools-menu.ps1
    │
    └───update

    
## Installation et utilisation

1. Clonez le dépôt ou téléchargez les fichiers sur votre machine locale.
2. Ouvrez une console PowerShell.
3. Exécutez le script principal `menu.ps1` pour afficher le menu interactif et accéder aux différentes fonctionnalités.
```bash
.\menu.ps1
```

L'interface vous guidera à travers les options disponibles, permettant d'exécuter des actions telles que la gestion des connexions réseau, le redémarrage du système, ou l'exécution d'outils d'administration.

## Extensibilité
ARC est conçu pour être facilement extensible. De nouveaux modules seront ajoutés en créant des scripts PowerShell dans le dossier modules. Chaque module peut être lié à un sous-menu dans le menu.ps1 pour une gestion centralisée des options.




### Notes
Ce script est conçu avec 💕 par DEVMJ.