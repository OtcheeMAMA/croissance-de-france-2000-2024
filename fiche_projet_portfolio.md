# Fiche projet — Croissance économique de la France, 2000-2024

**Type** : analyse macroéconomique et statistique · **Niveau** : Master 1 Économie appliquée, Université de La Réunion
**Outils** : R, RStudio, ggplot2 · **Durée de la série** : 25 ans · **Source** : Banque mondiale (WDI, `NY.GDP.MKTP.KD.ZG`)

## Problématique
Comment la croissance économique française a-t-elle évolué entre 2000 et 2024, et quelles sont les principales ruptures observées ?

## Ce que j'ai réalisé
- Importation et contrôle qualité d'une série annuelle de croissance du PIB réel (valeurs manquantes, doublons, continuité des années, unités).
- Statistiques descriptives complètes (moyenne, médiane, écart-type, minimum, maximum), avec et sans les années Covid-19.
- Identification des ruptures par la variation annuelle, classement des années en quatre régimes de croissance et analyse par sous-période.
- Trois visualisations ggplot2 exportées en PNG haute résolution.
- Un jeu de données enrichi (indice de niveau du PIB, régime, sous-période) et un script commenté exécutable du début à la fin.

## Résultats clés
- Croissance moyenne de **1,38 %** par an (médiane 1,65 %, écart-type 2,48 points) sur 2000-2024.
- Deux récessions : **2009 (−2,82 %)** et **2020 (−7,44 %)**, suivies de rebonds en 2010 et 2021 (+6,88 %).
- Une croissance moyenne de **2,26 %** avant la crise financière contre **1,41 %** sur 2010-2019.
- La séquence la plus longue de croissance faible : **2012-2016** (cinq années sous 1,5 %).
- Hors 2020-2021, la volatilité est presque divisée par deux (écart-type de 1,32 point).

## Compétences mobilisées
| Compétence | Illustration dans le projet |
|---|---|
| R | Script structuré, sans modélisation lourde, reproductible |
| Statistiques descriptives | Indicateurs de tendance centrale et de dispersion, sensibilité aux valeurs extrêmes |
| Visualisation de données | Courbe annotée, barres par régime, moyennes par période |
| Analyse macroéconomique | Lecture des cycles, des crises et des rebonds |
| Interprétation économique | Mise en contexte des ruptures (crise financière, zone euro, Covid-19) et limites assumées |

## Rigueur et transparence
Données issues de la Banque mondiale, aucune valeur inventée, seuils d'analyse explicités, limites du travail énoncées dans le rapport.

## Livrables
`scripts/analyse_croissance_france.R` · `data/` · `figures/` · `tables/` · `docs/rapport_synthese.md` · `README.md`
