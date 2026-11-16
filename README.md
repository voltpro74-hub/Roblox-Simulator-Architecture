# Architecture Professionnelle - Roblox Simulator

Structure propre et scalable pour un **Simulator** Roblox, prête pour Rojo + Git.

## Structure des dossiers

```
src/
├── server/                     → ServerScriptService.Server
│   ├── init.server.luau        → Bootstrap serveur (charge tous les Services)
│   └── Services/
│       ├── DataService.luau    → DataStores / Profiles (sauvegarde)
│       ├── EconomyService.luau → Monnaie, multipliers, clicks
│       ├── PetService.luau     → Gestion des pets
│       ├── EggService.luau     → Ouverture d'œufs
│       └── RebirthService.luau → Système de rebirth
│
├── client/                     → StarterPlayer.StarterPlayerScripts.Client
│   ├── init.client.luau        → Bootstrap client (charge les Controllers)
│   └── Controllers/
│       ├── UIController.luau
│       ├── InputController.luau
│       └── PetController.luau
│
├── shared/                     → ReplicatedStorage.Shared
│   ├── Modules/
│   │   ├── Constants.luau
│   │   ├── Types.luau
│   │   └── Utils.luau
│   ├── Configs/
│   │   ├── Eggs.luau
│   │   ├── Pets.luau
│   │   └── Economy.luau
│   └── Network/
│       └── Remotes.luau        → Création centralisée des RemoteEvents/Functions
│
└── serverStorage/              → ServerStorage.Modules (serveur uniquement)
    └── DataSchema.luau         → Schéma de données (versioning, migration)
```

## Principes

- **Services** (serveur) : logique métier, DataStores, sécurité
- **Controllers** (client) : UI, input, feedback visuel
- **Shared** : configs, types, utils, Network
- **Remotes** : tous centralisés et créés via `Remotes.luau` (jamais en dur dans Studio)
- **DataStores** : gérés uniquement dans `DataService` (recommandé : ProfileService / ProfileStore)

## Comment utiliser

1. Installer [Rojo](https://rojo.space/)
2. `rojo serve` dans le dossier du projet
3. Connecter le plugin Rojo dans Roblox Studio
4. Commencer à développer dans les Services / Controllers

## Bonnes pratiques incluses

- Séparation claire Server / Client / Shared
- Bootstrap ordonné (Init → Start)
- Remotes créés dynamiquement (anti-exploit + organisation)
- Schéma de données versionné
- Configs externalisées

Prêt pour un vrai simulator (clicks, eggs, pets, rebirths, trading, etc.).
