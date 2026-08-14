# taking test data from P:// CM-17 from 2026 spring to test out identification software

# data setup--------
library(tidyverse)
library(ggplot2)
library(lubridate)
library(dplyr)
library(fs)
library(esquisse)
library(hms)

# read in ID file

id17 <- read.csv("P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/ID/23.04.2026_CM-17/id.csv")

# # add site column
# id17$site <- "CM-17"
# id17$site <- NULL
# 
# # cut down on columns
# 
# cm17 <- id17 %>% 
#   rename(
#     filename = "OUT.FILE.FS",
#     autoid = "AUTO.ID.",
#     manualid = "MANUAL.ID") %>% 
#   mutate(autoid = factor(autoid)) %>% 
#   dplyr::select(OUTDIR, FOLDER, filename, DURATION, 
#                 DATE, TIME, HOUR,
#                 DATE.12, TIME.12, HOUR.12,
#                 autoid, manualid, site
  # )

# add correct outdir

# cm17$OUTDIR <- "P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/WAV/KPRO_V1_23.04.2026_CM-17/Data"
id17$OUTDIR <- "P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/WAV/KPRO_V1_23.04.2026_CM-17/Data"
id17$INDIR <- "P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/DATA/23.04.2026_CM-17"

# new column with Noise as NA value

# cm17$manual <- cm17$manualid
# cm17$manual[cm17$manual == ""] <- "Noise"


# separate manual id species

# cm17 <- cm17 %>%
#   mutate(manual = manual) %>%
#   separate_rows(manual, sep = "_")
# unique(cm17$manual)
# 
# barnoise <- ggplot(cm17) + 
#   geom_bar(aes(x= site, fill = manualid), position = "fill") +
#   ylab("Proportion of recordings") + 
#   xlab("Site") +
#   theme(text = element_text(size = 25)) 
# barnoise
# 


# make folders with data

# check what you have
# table(cm17$manualid)

table(id17$MANUAL.ID)


# Enil --------------------------------------------------------------------

# Select rows for ENIL
enil <- id17 %>%
  filter(MANUAL.ID == "ENIL")

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "ENIL")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(enil$OUTDIR, enil$IN.FILE),
  to = file.path(out_folder, enil$IN.FILE),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  enil,
  file.path(out_folder, "id_ENIL.csv"),
  row.names = FALSE
)



# Enil and Ppyg and Pnat --------------------------------------------------

# Select rows 
enilpp <- id17 %>%
  filter(MANUAL.ID == "ENIL_PNAT_PPYG")

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "ENILPP")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(enilpp$OUTDIR, enilpp$OUT.FILE.FS),
  to = file.path(out_folder, enilpp$OUT.FILE.FS),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  enilpp,
  file.path(out_folder, "id_ENILPP.csv"),
  row.names = FALSE
)

# Enil and other bats -----------------------------------------------------

# Select rows 
enil2 <- id17 %>%
  filter(MANUAL.ID %in% c(
    "ENIL_MYSP_PPYG",
    "ENIL_PNAT",
    "ENIL_PPYG"
  ))

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "ENIL2")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(enil2$OUTDIR, enil2$OUT.FILE.FS),
  to = file.path(out_folder, enil2$OUT.FILE.FS),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  enil2,
  file.path(out_folder, "id_ENIL2.csv"),
  row.names = FALSE
)


# Pnat and Ppyg -----------------------------------------------------------

# Select rows
pips <- id17 %>%
  filter(MANUAL.ID == "PNAT_PPYG")

# random 100

set.seed(14)  

pips_100 <- pips %>%
  slice_sample(n = 100)

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "PIPS")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(pips_100$OUTDIR, pips_100$OUT.FILE.FS),
  to = file.path(out_folder, pips_100$OUT.FILE.FS),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  pips_100,
  file.path(out_folder, "id_PIPS.csv"),
  row.names = FALSE
)


# Myotis and others --------------------------------------------------------------------

# Select rows
myo <- id17 %>%
  filter(MANUAL.ID %in% c(
    "MYSP",
    "MYSP_PNAT",
    "MYSP_PNAT_PPYG",
    "MYSP_PPYG"
  ))

# random 100

set.seed(14)  

myo_100 <- myo %>%
  slice_sample(n = 100)

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "MYSP")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(myo_100$OUTDIR, myo_100$OUT.FILE.FS),
  to = file.path(out_folder, myo_100$OUT.FILE.FS),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  myo_100,
  file.path(out_folder, "id_MYO.csv"),
  row.names = FALSE
)




# Noise -------------------------------------------------------------------

# Select rows
noi <- id17 %>%
  filter(MANUAL.ID == "Noise")

# random 100

set.seed(14)  

noi_100 <- noi %>%
  slice_sample(n = 100)

# Create output folder
out_folder <- file.path("C:/Users/mapa/OneDrive - Norwegian University of Life Sciences/Documents/R for data/Test_data", "NOISE")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = file.path(noi_100$OUTDIR, noi_100$OUT.FILE.FS),
  to = file.path(out_folder, noi_100$OUT.FILE.FS),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  noi_100,
  file.path(out_folder, "id_noise.csv"),
  row.names = FALSE
)




