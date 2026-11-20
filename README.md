# Projet 2 — Analyse de la croissance économique en France (2000-2024)

Analyse descriptive avec R de la croissance annuelle du PIB réel français : statistiques, ruptures, périodes de croissance faible et forte, trois graphiques ggplot2.

## Structure du dossier
```
projet2_croissance_france/
├── README.md
├── data/
│   ├── pib_france_2000_2024.csv            # données sources (annee, croissance_pib_pct)
│   └── pib_france_2000_2024_enrichi.csv    # produit par le script
├── scripts/analyse_croissance_france.R     # script complet et commenté
├── figures/                                # 3 graphiques PNG (produits par le script)
├── tables/                                 # statistiques descriptives et par période, journal d'exécution
└── docs/
    ├── rapport_synthese.md                 # rapport de synthèse
    └── fiche_projet_portfolio.md           # fiche pour le portfolio
```

## Reproduire l'analyse
1. Installer R (≥ 4.0) et RStudio, puis le package : `install.packages("ggplot2")`.
2. Ouvrir le script `scripts/analyse_croissance_france.R` dans RStudio.
3. Définir le répertoire de travail à la racine du projet : *Session > Set Working Directory > To Project Directory* (ou `setwd("chemin/vers/projet2_croissance_france")`).
4. Exécuter tout le script (*Source* ou Ctrl+Shift+Enter). Les fichiers de `figures/` et `tables/` sont recréés.

En ligne de commande : `Rscript scripts/analyse_croissance_france.R` depuis la racine du projet.

## Données
- **Indicateur** : PIB, croissance annuelle (% annuel), prix constants.
- **Source** : Banque mondiale, *World Development Indicators*, `NY.GDP.MKTP.KD.ZG`, France. https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG?locations=FR
- **Valeurs relevées** sur la page StatisticsTimes.com *GDP Growth of France* (mise à jour du 26/01/2026), qui relaie les estimations de la Banque mondiale. 25 années, aucune valeur manquante, aucune valeur inventée.
- **À faire avant diffusion** : comparer les 25 valeurs au téléchargement officiel (page ci-dessus, bouton *Download*, format CSV) et, si des écarts existent, remplacer la colonne `croissance_pib_pct`. Le script recalcule alors tout automatiquement. Les séries étant révisées, de légers écarts sont possibles, surtout pour 2023-2024.

## Vérification
Le script a été exécuté du début à la fin avec R 4.3.3 et ggplot2 (aucune erreur). Les statistiques descriptives et les moyennes par sous-période ont été recalculées avec Python et sont identiques. Les trois graphiques ont été contrôlés visuellement. Le journal d'exécution est dans `tables/journal_execution.txt`.

Sur certains systèmes Windows, les accents peuvent s'afficher mal dans la console R ; les fichiers CSV et les graphiques restent en UTF-8.

## Auteur
Projet réalisé dans le cadre du Master 1 Économie appliquée, Université de La Réunion.
