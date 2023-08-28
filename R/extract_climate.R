# Author: Abhishek Kumar
# Affiliation: Panjab University, Chandigarh
# Email: abhikumar.pu@gmail.com

library(sf)
library(terra)
library(tidyverse)

## bounding box of study area
ssb <- st_bbox(c(xmin = 76.75, ymin = 30.54, xmax = 77.56, ymax = 31.02),
               crs = st_crs(4326)) |> st_as_sfc()

## monthly precipitation
sprec <- list.files("E:/spatial-data/climate/chelsa/pr", 
                   full.names = TRUE) |> rast() |> crop(vect(ssb))
names(sprec) <- month.abb

## monthly average temperature
tavg <- list.files("E:/spatial-data/climate/chelsa/tas", 
                   full.names = TRUE) |> rast() |> crop(vect(ssb))
names(tavg) <- month.abb

## Boundary for study area
mh <- st_read("data/morni.gpkg", quiet = TRUE) |>
  summarise() |> mutate(Name = "Morni Hills") |> st_transform(4326)
chail <- st_read("data/chail.gpkg", quiet = T) |>
  summarise() |> mutate(Name = "Chail")
churdhar <- st_read("data/chur.gpkg", quiet = T) |>
  summarise() |> mutate(Name = "Churdhar")
sites_all <- bind_rows(mh, chail, churdhar) |> summarise() |> mutate(Name = "All")
study_area <- bind_rows(mh, chail, churdhar, sites_all)

## WorlClim site data
bind_rows(
  sprec |> terra::extract(study_area, fun = mean) |> mutate(Clim = "prec"),
  tavg  |> terra::extract(study_area, fun = mean) |> mutate(Clim = "tavg")
) |>
  mutate(ID = factor(
    ID, levels = c(1:4),
    labels = c("Morni Hills", "Chail WLS", "Churdhar WLS", "All Sites")
  )) |>
  select(ID, Clim, Jan:Dec) |>
  write.csv("data/site_climate_chelsa.csv", row.names = F)
