# ARC (Assistant d'Adminsitration, de Reparation et de Configuration)

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

    
## Utilisation

Lancer `menu.ps1` dans une console PowerShell.

