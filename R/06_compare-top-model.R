################################################################################
## Author: Abhishek Kumar
## Affiliation: Panjab University, Chandigarh
## Email: abhikumar.pu@gmail.com
################################################################################

## load required packages
library(MuMIn)
library(tidyverse)

################################################################################

## function to calculate corrected aic (AICc) -----
aicc <- function(model) {
  n <- length(model$y)
  k <- length(model$coefficients)
  aic <- AIC(model)
  return(aic + 2*k*(k+1)/(n-k-1))
}

## function to calculate corrected deviance explained -----
d2.adj <- function(model) {
  n <- length(model$y)
  k <- length(model$coefficients)
  d2 <- 1 - (summary(model)$deviance / summary(model)$null.deviance)
  d2a <- (1 - ((1 - d2)*(n - 1) / (n - k - 1)))
  return(d2a)
}

## function to compare models -----
mod.comp <- function(tmod.fm, site_x){
  
  ## top model to compare
  tmod <- glm(as.formula(tmod.fm), family = "poisson", data = site_x)
  
  ## formulas for earlier used models
  fm <- rbind(
    "S ~ AET",
    "S ~ MAP",
    "S ~ MAT",  ## metabolic theory of ecology
    "S ~ NPP",  ## energy availability
    "S ~ WDF",  ## water energy dynamics
    
    "S ~ MAP + I(PET^2)",
    "S ~ MAP + I(PET - PET^2)",
    "S ~ NPP + I(NPP^2)",
    "S ~ PET + I(PET^2)",
    
    "S ~ ELE + MAP + PET",
    "S ~ ELE + MAP + TSE",
    "S ~ MAP + I(PET - PET^2) + TRI",
    "S ~ MAP + PET + I(PET^2)",
    "S ~ WDF + PET + I(PET^2)",
    "S ~ WDF + MAT + WDF:MAT"
  ) |>
    rbind(tmod.fm)
  
  
  ## data list to collect model fit parameters
  datalist <- list()
  
  for (i in 1:nrow(fm)){
    ## previous models
    mod <- glm(as.formula(fm[i]), family = "poisson", data = site_x)
    
    ## collect model parameters
    datalist[[i]] <- data.frame(
      Model  = fm[i],
      logLik = logLik(mod),
      AICc   = aicc(mod),
      daicc  = aicc(mod) - aicc(tmod),
      dev.adj = d2.adj(mod)*100
    )
  }
  
  do.call(dplyr::bind_rows, datalist) |>
    arrange(daicc)
}

################################################################################

## prepare data for each site
site_morni <- read.csv("output/site_env.csv") |>
  filter(site == "Morni") |>
  select(-site) |>
  mutate(across(!S, ~scale(.x)))

site_chail <- read.csv("output/site_env.csv") |>
  filter(site == "Chail") |>
  select(-site) |>
  mutate(PET = sqrt(PET)) |>
  mutate(across(!S, ~scale(.x)))

site_churdhar <- read.csv("output/site_env.csv") |>
  filter(site == "Churdhar") |>
  select(-site) |>
  mutate(across(!S, ~scale(.x)))

site_all <- read.csv("output/site_env.csv") |>
  filter(site == "All") |>
  select(-site) |>
  mutate(WDF = log(WDF)) |>
  mutate(across(!S, ~scale(.x)))

################################################################################

cmod_morni <-    mod.comp("S ~ AET + WDF",       site_x = site_morni)
cmod_chail <-    mod.comp("S ~ TRI",             site_x = site_chail)
cmod_churdhar <- mod.comp("S ~ AET + MAP",       site_x = site_churdhar)
cmod_all <-      mod.comp("S ~ NPP + EHM + TRI", site_x = site_all)

bind_rows(
  mutate(cmod_morni,    Site = "Morni"),
  mutate(cmod_chail,    Site = "Chail"),
  mutate(cmod_churdhar, Site = "Churdhar"),
  mutate(cmod_all,      Site = "All")
) |>
  relocate(Site) |>
  write.csv("output/top_mod_comparison.csv", row.names = FALSE)
