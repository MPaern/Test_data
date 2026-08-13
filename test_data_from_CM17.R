# taking test data from P:// CM-17 from 2026 spring to test out identification software

# data setup--------
library(tidyverse)
library(ggplot2)
library(lubridate)
library(dplyr)
library(fs)
library(esquisse)
library(hms)
library(MoMAColors)

# read in ID file

id17 <- read.csv("P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/ID/23.04.2026_CM-17/id.csv")

# add site column
id17$site <- "CM-17"

# cut down on columns

cm17 <- id17 %>% 
  rename(
    filename = "OUT.FILE.FS",
    autoid = "AUTO.ID.",
    manualid = "MANUAL.ID") %>% 
  mutate(autoid = factor(autoid)) %>% 
  dplyr::select(OUTDIR, FOLDER, filename, DURATION, 
                DATE, TIME, HOUR,
                DATE.12, TIME.12, HOUR.12,
                autoid, manualid, site
  )

# add correct outdir

cm17$OUTDIR <- "P:/SW_CoastalMonitoring/Data_collection_2026/CM-17/WAV/KPRO_V1_23.04.2026_CM-17"

# new column with Noise as NA value

cm17$manual <- cm17$manualid
cm17$manual[cm17$manual == ""] <- "Noise"


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
# table(cm17$manualid)

# make folders with data

# Select rows for ENIL
enil <- cm17 %>%
  filter(manualid == "ENIL")

# Create output folder
out_folder <- file.path("x", "ENIL")
dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)

# Copy the corresponding files
file.copy(
  from = enil$file_path,
  to = file.path(out_folder, basename(enil$file_path)),
  overwrite = FALSE
)

# Save the subset of the CSV with ALL columns
write.csv(
  enil,
  file.path(out_folder, "metadata_ENIL.csv"),
  row.names = FALSE
)




