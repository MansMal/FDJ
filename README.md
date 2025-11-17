# FDJ - Paris Sportifs – iOS App

Application iOS permettant de rechercher des ligues sportives et d’afficher leurs équipes via l’API publique TheSportsDB.
L'exercice impose : recherche avec auto-complétion, sélection d’une league, récupération et affichage des équipes, tri anti-alphabétique et filtre d’index (1 équipe sur 2).

Table des matières

Fonctionnalités

Architecture

 API

 Aperçu

 Installation

 Configuration

 Structure du projet

 Améliorations possibles

 Licence

-Fonctionnalités
Recherche de leagues

Auto-complétion basée sur strLeague

Mise à jour en temps réel

Liste des leagues

Chargée via all_leagues.php

Affichage du nom + sport

Navigation

Sélection d’une league → liste des équipes

À partir de search_all_teams.php :

Tri anti-alphabétique (Z → A)

Affichage 1 équipe sur 2 (index pair)

Logo + nom + league

Architecture MVVM

ViewModels testables

API client découplé via protocole

Architecture

Le projet utilise :

SwiftUI pour l’interface

MVVM comme pattern d’architecture

async/await pour le réseau

AsyncImage pour les logos

NavigationView / NavigationLink pour la navigation

API:
TheSportsDB – Version gratuite

Base URL :

https://www.thesportsdb.com/api/v1/json/123


Endpoints utilisés :

all_leagues.php → liste des ligues

search_all_teams.php?l={league} → équipes d’une league

Aucune API key requise pour ces endpoints.


Ajoute facilement vos captures d’écran dans ce dossier :
Assets/Screenshots

Exemple (mockups générés) :

Recherche de leagues    Équipes d'une league

    

(Je peux te fournir des captures plus réalistes si tu veux.)

Installation
git clone https://github.com/ton-repo/paris-sportifs-ios.git
cd paris-sportifs-ios
open ParisSportifs.xcodeproj


Lancer ensuite le projet dans Xcode (iOS 15+ requis).

Configuration

Aucune configuration nécessaire.
L’API fonctionne sans clé pour les endpoints requis.

Structure:
├── Models
│   ├── League.swift
│   └── Team.swift
├── Networking
│   └── SportsAPIClient.swift
├── ViewModels
│   ├── LeagueSearchViewModel.swift
│   └── TeamsViewModel.swift
└── Views
    ├── LeagueSearchView.swift
    └── TeamsListView.swift





Améliorations possibles

Ajout de tests unitaires (mock API)

Persistences des résultats (cache local)

Mode sombre personnalisé

Utilisation de NavigationStack (iOS 16+)

Vue détaillée d'une équipe

Accessibilité (VoiceOver)
