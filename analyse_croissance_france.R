# =============================================================================
# PROJET 2 - Analyse descriptive de la croissance économique en France (2000-2024)
# Master 1 Économie appliquée - Université de La Réunion
# -----------------------------------------------------------------------------
# Indicateur : PIB, croissance annuelle (% annuel), prix constants
#              Banque mondiale, WDI, code NY.GDP.MKTP.KD.ZG, pays : France (FRA)
# Mode d'emploi : ouvrir le dossier du projet dans RStudio (Session > Set Working
#                 Directory > To Project Directory), puis exécuter tout le script.
# Packages requis : ggplot2 (seul package externe)
# =============================================================================

library(ggplot2)

# --- 0. Préparation des dossiers ---------------------------------------------
fichier_donnees <- "data/pib_france_2000_2024.csv"
if (!file.exists(fichier_donnees)) {
  stop("Fichier introuvable. Définir le répertoire de travail à la racine du projet.")
}
dir.create("figures", showWarnings = FALSE)
dir.create("tables",  showWarnings = FALSE)

# --- 1. Importation ----------------------------------------------------------
pib <- read.csv(fichier_donnees)
str(pib)
head(pib)

# --- 2. Nettoyage et contrôles -----------------------------------------------
names(pib) <- c("annee", "croissance")          # noms de colonnes courts
cat("\nValeurs manquantes :", sum(is.na(pib$croissance)), "\n")
cat("Années :", min(pib$annee), "à", max(pib$annee),
    "| nombre d'observations :", nrow(pib), "\n")
stopifnot(!anyNA(pib),                            # aucune valeur manquante
          !anyDuplicated(pib$annee),              # aucune année en double
          all(diff(pib$annee) == 1),              # série annuelle continue
          is.numeric(pib$croissance))             # unité : pourcentage (%)

# --- 3. Statistiques descriptives --------------------------------------------
summary(pib$croissance)
stats <- data.frame(
  statistique = c("Moyenne", "Médiane", "Écart-type", "Minimum", "Maximum"),
  valeur_pct  = round(c(mean(pib$croissance), median(pib$croissance),
                        sd(pib$croissance), min(pib$croissance),
                        max(pib$croissance)), 2)
)
print(stats)
cat("Année du minimum :", pib$annee[which.min(pib$croissance)],
    "| Année du maximum :", pib$annee[which.max(pib$croissance)], "\n")

# Mêmes statistiques hors 2020-2021 (chocs exceptionnels liés au Covid-19)
hors_covid <- pib$croissance[!(pib$annee %in% c(2020, 2021))]
cat("Hors 2020-2021 : moyenne =", round(mean(hors_covid), 2),
    "| médiane =", round(median(hors_covid), 2),
    "| écart-type =", round(sd(hors_covid), 2), "\n")

write.csv(stats, "tables/statistiques_descriptives.csv", row.names = FALSE)

# --- 4. Évolution annuelle ---------------------------------------------------
# Variation d'une année sur l'autre (en points de pourcentage)
pib$variation_pts <- c(NA, diff(pib$croissance))
# Niveau du PIB réel en indice (base 100 en 1999) : cumul des taux de croissance
pib$indice_1999_100 <- round(100 * cumprod(1 + pib$croissance / 100), 1)

# Plus fortes variations d'une année sur l'autre = ruptures
ordre <- order(abs(pib$variation_pts), decreasing = TRUE)
ruptures <- pib[ordre[1:3], c("annee", "croissance", "variation_pts")]
cat("\nTrois plus fortes ruptures (variation en points) :\n")
print(ruptures)

# --- 5. Périodes de croissance faible et forte -------------------------------
# Seuils choisis pour cette analyse (conventions de lecture, pas de norme officielle) :
#   Récession : < 0 % | Faible : 0 à 1,5 % | Modérée : 1,5 à 2,5 % | Forte : >= 2,5 %
pib$regime <- cut(pib$croissance,
                  breaks = c(-Inf, 0, 1.5, 2.5, Inf), right = FALSE,
                  labels = c("Récession", "Faible", "Modérée", "Forte"))
print(table(pib$regime))

# Séquences d'années consécutives de croissance < 1,5 %
faible <- pib$croissance < 1.5
sequences <- rle(faible)
fin    <- cumsum(sequences$lengths)
debut  <- fin - sequences$lengths + 1
cat("\nSéquences d'années à croissance < 1,5 % :\n")
for (i in which(sequences$values)) {
  cat(" ", pib$annee[debut[i]], "-", pib$annee[fin[i]],
      "(", sequences$lengths[i], "an(s) )\n")
}

# Sous-périodes économiques (choix de l'analyste, justifié dans le rapport)
pib$periode <- cut(pib$annee,
                   breaks = c(1999, 2007, 2009, 2019, 2021, 2024),
                   labels = c("2000-2007 Avant-crise", "2008-2009 Crise financière",
                              "2010-2019 Reprise lente", "2020-2021 Covid-19",
                              "2022-2024 Post-Covid"))
par_periode <- data.frame(
  periode = levels(pib$periode),
  moyenne = round(as.numeric(tapply(pib$croissance, pib$periode, mean)), 2),
  mediane = round(as.numeric(tapply(pib$croissance, pib$periode, median)), 2),
  min     = as.numeric(tapply(pib$croissance, pib$periode, min)),
  max     = as.numeric(tapply(pib$croissance, pib$periode, max))
)
print(par_periode)
write.csv(par_periode, "tables/statistiques_par_periode.csv", row.names = FALSE)

# Jeu de données enrichi
write.csv(pib, "data/pib_france_2000_2024_enrichi.csv", row.names = FALSE)

# --- 6. Graphiques -----------------------------------------------------------
couleurs <- c("Récession" = "#B2182B", "Faible" = "#EF8A62",
              "Modérée" = "#67A9CF", "Forte" = "#2166AC")
theme_projet <- theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"),
        plot.caption = element_text(color = "grey40", size = 9))
source_txt <- "Source : Banque mondiale, WDI (NY.GDP.MKTP.KD.ZG). Calculs de l'auteur."

# Graphique 1 : évolution annuelle avec moyenne
g1 <- ggplot(pib, aes(x = annee, y = croissance)) +
  geom_hline(yintercept = 0, color = "grey50") +
  geom_hline(yintercept = mean(pib$croissance), linetype = "dashed", color = "firebrick") +
  geom_line(color = "#2166AC", linewidth = 0.9) +
  geom_point(color = "#2166AC", size = 2) +
  annotate("text", x = 2012, y = 4.2,
           label = paste0("Moyenne 2000-2024 : ",
                          format(round(mean(pib$croissance), 2), decimal.mark = ","),
                          " % (pointillés)"),
           color = "firebrick", hjust = 0, size = 3.8) +
  annotate("text", x = 2009, y = -2.82 - 0.9, label = "2009", size = 3.5) +
  annotate("text", x = 2020, y = -7.44 - 0.9, label = "2020", size = 3.5) +
  annotate("text", x = 2021, y = 6.88 + 0.8,  label = "2021", size = 3.5) +
  scale_x_continuous(breaks = seq(2000, 2024, 4)) +
  labs(title = "Croissance annuelle du PIB réel de la France, 2000-2024",
       x = "Année", y = "Croissance du PIB réel (%)", caption = source_txt) +
  theme_projet
ggsave("figures/graphique1_evolution_annuelle.png", g1, width = 9, height = 5.5, dpi = 300, bg = "white")

# Graphique 2 : barres selon le régime de croissance
g2 <- ggplot(pib, aes(x = annee, y = croissance, fill = regime)) +
  geom_col() +
  geom_hline(yintercept = 0, color = "grey30") +
  scale_fill_manual(values = couleurs, name = "Régime") +
  scale_x_continuous(breaks = seq(2000, 2024, 2)) +
  labs(title = "Années de croissance faible, modérée et forte",
       subtitle = "Seuils : < 0 % récession ; 0-1,5 % faible ; 1,5-2,5 % modérée ; >= 2,5 % forte",
       x = "Année", y = "Croissance du PIB réel (%)", caption = source_txt) +
  theme_projet + theme(legend.position = "bottom")
ggsave("figures/graphique2_regimes_croissance.png", g2, width = 9, height = 5.5, dpi = 300, bg = "white")

# Graphique 3 : croissance moyenne par sous-période
par_periode$periode <- factor(par_periode$periode, levels = par_periode$periode)
g3 <- ggplot(par_periode, aes(x = periode, y = moyenne, fill = moyenne > 0)) +
  geom_col(width = 0.7, show.legend = FALSE) +
  geom_hline(yintercept = 0, color = "grey30") +
  geom_text(aes(label = paste0(moyenne, " %"),
                vjust = ifelse(moyenne >= 0, -0.5, 1.5)), size = 4) +
  scale_fill_manual(values = c("TRUE" = "#2166AC", "FALSE" = "#B2182B")) +
  scale_x_discrete(labels = function(x) sub(" ", "\n", x)) +
  labs(title = "Croissance moyenne du PIB réel par sous-période",
       x = NULL, y = "Croissance annuelle moyenne (%)", caption = source_txt) +
  theme_projet
ggsave("figures/graphique3_moyenne_par_periode.png", g3, width = 9, height = 5.5, dpi = 300, bg = "white")

cat("\nAnalyse terminée : graphiques dans figures/, tableaux dans tables/.\n")
