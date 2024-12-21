library(readr)
library(dplyr)

whalen <- read_csv("Whalen_grazer_removal_2009_summary.csv")


# Filter and combine like Grace 2021
# from https://zenodo.org/records/4593587
# https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.13600

whalen_iv_out <- whalen |>
  filter(time == "2weeks") |>
  mutate(trt = ifelse(pesticide.treatment==0,-1,1),
         grazers = scale(LNGammarids+LNCaprellids),
         epis = scale(log(chla)),
         macroalgae = scale(log(Macroalgae.grams+0.01)),
         seagrass = scale(LNGrass)) |>
  select(pole, trt, grazers, epis, macroalgae, seagrass) |>
  mutate(across(everything(), as.numeric)) # gets rid of artefacts from scale

write_csv(whalen_iv_out, "whalen_iv_ex.csv")
