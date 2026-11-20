# La croissance économique française entre 2000 et 2024 : évolution et ruptures

**Analyse descriptive avec R** · Master 1 Économie appliquée · Université de La Réunion

---

## 1. Problématique

Comment la croissance économique française a-t-elle évolué entre 2000 et 2024, et quelles sont les principales ruptures observées ?

## 2. Données et méthode

| Élément | Détail |
|---|---|
| Indicateur | PIB, croissance annuelle (% annuel), à prix constants |
| Source | Banque mondiale, *World Development Indicators*, code `NY.GDP.MKTP.KD.ZG`, France (FRA) |
| Lien | https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG?locations=FR |
| Période | 2000-2024, soit 25 observations annuelles |
| Unité | Pourcentage (%) par rapport à l'année précédente |
| Contrôles | 0 valeur manquante, 0 doublon, série annuelle continue (vérifiés dans le script) |
| Outils | R 4.3.3, `read.csv`, `summary`, `mean`, `median`, `sd`, `ggplot2` |

**Provenance exacte des valeurs.** Les 25 valeurs ont été relevées sur la page *GDP Growth of France* de StatisticsTimes.com (mise à jour du 26 janvier 2026), qui relaie les estimations de la Banque mondiale. Elles n'ont pas été téléchargées directement depuis le portail de la Banque mondiale. Aucune valeur n'a été estimée ou inventée. Avant toute diffusion, il est recommandé de comparer ces 25 valeurs au téléchargement officiel (voir le README). Les séries sont révisées périodiquement : l'INSEE ou une version ultérieure de la Banque mondiale peuvent donner des chiffres légèrement différents, en particulier pour les années récentes.

**Méthode.** Statistiques descriptives sur l'ensemble de la période, variation d'une année sur l'autre, classement des années en quatre régimes selon des seuils fixés par l'analyste (récession < 0 % ; faible 0-1,5 % ; modérée 1,5-2,5 % ; forte ≥ 2,5 %), et moyennes par sous-période. Ces seuils sont des conventions de lecture, non des normes officielles.

## 3. Résultats

### 3.1 Statistiques descriptives (2000-2024)

| Statistique | Valeur |
|---|---|
| Moyenne | 1,38 % |
| Médiane | 1,65 % |
| Écart-type | 2,48 points |
| Minimum | −7,44 % (2020) |
| Maximum | +6,88 % (2021) |

La moyenne est inférieure à la médiane parce que la récession de 2020 tire la moyenne vers le bas. Hors 2020 et 2021, la moyenne passe à 1,53 %, la médiane reste à 1,65 % et l'écart-type tombe à 1,32 point. Les deux années du Covid-19 expliquent donc à elles seules près de la moitié de la dispersion apparente.

En cumulant les taux, le PIB réel de 2024 est environ 40 % plus élevé que celui de 1999 (indice 139,9 ; base 100 en 1999), soit environ 1,35 % de croissance annuelle moyenne composée. Ce calcul additionne des taux arrondis : il donne un ordre de grandeur.

### 3.2 Évolution annuelle

![Évolution annuelle](../figures/graphique1_evolution_annuelle.png)

La série est stable autour de 1 à 3 % hors chocs, avec trois ruptures nettes : 2009, 2020 et 2021. Les plus fortes variations d'une année sur l'autre sont +14,32 points en 2021, −9,47 points en 2020 et +4,82 points en 2010.

### 3.3 Périodes de croissance faible et forte

![Régimes de croissance](../figures/graphique2_regimes_croissance.png)

Répartition des 25 années : 2 récessions (2009, 2020), 10 années de croissance faible, 7 modérées et 6 fortes (2000, 2004, 2006, 2007, 2021, 2022). Les séquences d'années consécutives sous 1,5 % sont : 2002-2003, 2008-2009, 2012-2016 (cinq ans, la plus longue), 2020 et 2023-2024.

### 3.4 Croissance moyenne par sous-période

![Moyenne par sous-période](../figures/graphique3_moyenne_par_periode.png)

| Sous-période | Moyenne | Médiane |
|---|---|---|
| 2000-2007 Avant-crise | 2,26 % | 2,21 % |
| 2008-2009 Crise financière | −1,22 % | −1,22 % |
| 2010-2019 Reprise lente | 1,41 % | 1,36 % |
| 2020-2021 Covid-19 | −0,28 % | −0,28 % |
| 2022-2024 Post-Covid | 1,78 % | 1,44 % |

Le découpage en sous-périodes est un choix de l'analyste, fondé sur les événements macroéconomiques majeurs. La moyenne de 2020-2021 (−0,28 %) masque deux années très différentes : elle résulte de la compensation presque complète entre la chute de 2020 et le rebond de 2021.

## 4. Interprétation économique

**Un régime avant-crise relativement dynamique (2000-2007).** La croissance moyenne de 2,26 % est la plus élevée des périodes « normales ». Le chiffre de 2000 (4,14 %) est le sommet de la phase d'expansion de la fin des années 1990. Il est suivi d'un ralentissement en 2002-2003, cohérent avec l'essoufflement conjoncturel du début des années 2000, puis d'un retour vers 2,5-2,9 % entre 2004 et 2007.

**La crise financière de 2008-2009, première rupture.** La croissance tombe à 0,38 % en 2008, puis à −2,82 % en 2009 : le choc touche la demande, l'investissement et le commerce extérieur. Le rebond de 2010 (+2,00 %) est rapide, mais il ne ramène pas la France sur la trajectoire d'avant 2008.

**Une décennie de reprise lente (2010-2019).** La croissance moyenne (1,41 %) reste inférieure d'environ 0,85 point à celle de 2000-2007. La séquence 2012-2016 (entre 0,18 % et 1,07 % par an) correspond à la période de faiblesse de la demande en zone euro après la crise de la dette souveraine. Cette interprétation est une lecture contextuelle ; le projet descriptif ne la teste pas statistiquement. La reprise de 2017-2019 (autour de 2 % par an) reste modérée.

**Le choc du Covid-19 (2020-2021), rupture la plus violente.** Les restrictions sanitaires provoquent la plus forte contraction de la période (−7,44 %), puis un rebond de +6,88 % en 2021. Le niveau du PIB réel en 2021 (indice 132,6) se situe encore légèrement sous celui de 2019 (134,1) : le rebond de 2021 est en grande partie un effet de rattrapage statistique après une base très basse, pas un nouveau régime de croissance forte.

**Un retour vers une croissance faible (2022-2024).** Après +2,72 % en 2022, la croissance ralentit à 1,44 % puis 1,19 %. Ce profil s'inscrit dans un contexte de hausse des prix de l'énergie, d'inflation et de resserrement monétaire, facteurs qu'il convient de vérifier avec des sources complémentaires (INSEE, Banque de France) avant toute conclusion causale.

**Conclusion.** Sur 2000-2024, la croissance française est passée d'un régime autour de 2-2,5 % avant 2008 à un régime autour de 1-1,5 % après les crises, ponctué par deux chocs majeurs (2009 et 2020). Les ruptures sont davantage des chocs conjoncturels suivis de rebonds que des changements durables de tendance, mais le niveau de croissance « normal » semble plus bas après 2008. Cette dernière observation reste descriptive.

## 5. Limites

- Analyse descriptive : aucune causalité n'est testée et aucun test statistique de rupture structurelle n'est mené.
- Seuils et sous-périodes choisis par l'analyste ; d'autres choix donneraient des moyennes différentes.
- Série arrondie à deux décimales et sujette à révisions (voir section 2). Le PIB total ne tient pas compte de la population ni de la répartition des revenus.
- Les explications économiques de la section 4 sont des lectures contextuelles, à documenter par des sources complémentaires (INSEE, Banque de France, OCDE) pour un rendu académique.

## 6. Références

- Banque mondiale, *World Development Indicators*, « GDP growth (annual %) », `NY.GDP.MKTP.KD.ZG` : https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG?locations=FR
- Valeurs relevées via StatisticsTimes.com, *GDP Growth of France* (mise à jour du 26 janvier 2026) : https://statisticstimes.com/economy/country/france-gdp-growth.php
