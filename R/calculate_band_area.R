################################################################################
## Author: Abhishek Kumar
## Affiliation: Panjab University, Chandigarh
## Email: abhikumar.pu@gmail.com
################################################################################

## load the required packages
library(sf)
library(terra)
library(tidyverse)

#################################################################
## ----- function to calculate area for elevational bands -----
#################################################################

## shp: shapefile for study site
## elev.raster: elevation data for study site in raster format
## resamp.raster: raster to which elevation is resampled
## site: name of study site
## band.size: size of each elevational band, default to 100

## function to calculate area for elevational bands
calc.area <- function(shp, elev.raster, resamp.raster, site, band.size = 100){
  
  ## re-sample, crop, mask elevation to site boundary
  elev_mask <- elev.raster |> resample(resamp.raster) |>
    crop(vect(shp)) |> mask(vect(shp))
  names(elev_mask) <- "elevation"  ## assign name
  
  ## create elevational bands

  ## minimum and maximum elevation values
  min_elev <- minmax(elev_mask)[1] |> round(-2)
  max_elev <- minmax(elev_mask)[2] |> round(-2)
  
  ## round min and max values
  elev_mask[elev_mask < min_elev] <- min_elev
  elev_mask[elev_mask > max_elev] <- max_elev
  
  ## reclassification matrix
  rcl <- data.frame(from = seq(min_elev, max_elev - band.size, band.size),
                    to = seq(min_elev + band.size, max_elev, band.size),
                    elevation = seq(min_elev + band.size, max_elev, band.size)) |>
    as.matrix()
  
  ## reclassify elevation raster
  elev100 <- elev_mask |> classify(rcl)
  
  ## ----- Estimate 3d area -----
  ## calculate area of each pixel
  px_area <- elev.raster |> resample(resamp.raster) |>
    crop(vect(shp)) |> cellSize(unit = "km")
  ## estimate slope value for each pixel
  px_slope <- elev.raster |> resample(resamp.raster) |>
    crop(vect(shp)) |> terrain("slope", unit = "radians")
  ## estimate 3d area
  area3d <- px_area / cos(px_slope)
  ## calculate 3d area
  r <- zonal(area3d, elev100, fun = "sum", na.rm = TRUE) |>
    rename("area3d" = area)
  
  ## calculate 2d area
  df <- expanse(elev100, unit = "km", byValue = TRUE) |> 
    rename("elevation" = value) |>
    left_join(r)
  
  ## add column for site name
  df$site <- site
  
  ## return dataframe
  return(df)
}

#################################################################
## ----- read spatial boundary and elevation for each site -----
#################################################################

## boundaries for sites
mh <- st_read("data/morni.gpkg", quiet = TRUE) |>
  summarise() |> 
  mutate(Name = "Morni Hills") |> 
  st_transform(4326)
chail <- st_read("data/chail.gpkg", quiet = T) |>
  summarise() |> 
  mutate(Name = "Chail")
churdhar <- st_read("data/churdhar.gpkg", quiet = T) |>
  summarise() |> 
  mutate(Name = "Churdhar")
all_sites <- bind_rows(mh, chail, churdhar)

## reference raster for resampling
resamp_raster <- rast("data/site_bio_chelsa.tif")

## elevation raster for sites
elev_mh    <- rast("output/morni_elev.tif")
elev_chail <- rast("output/chail_elev.tif")
elev_chur  <- rast("output/churdhar_elev.tif")
elev_all   <- rast("output/site_elev.tif")

#################################################################
## ----- calculate area for each site -----
#################################################################

# bind all data
bind_rows(
  calc.area(mh,        elev_mh,    resamp_raster, site = "Morni"),
  calc.area(chail,     elev_chail, resamp_raster, site = "Chail"),
  calc.area(churdhar,  elev_chur,  resamp_raster, site = "Churdhar"),
  calc.area(all_sites, elev_all,   resamp_raster, site = "All")
) |>
  mutate(elevation = ifelse(site == "Morni"    & elevation > 1300, 1300, elevation),
         elevation = ifelse(site == "Chail"    & elevation > 2100, 2100, elevation),
         elevation = ifelse(site == "Churdhar" & elevation < 1700, 1700, elevation),
         elevation = ifelse(site == "Churdhar" & elevation > 3400, 3400, elevation)) |>
  group_by(elevation, site) |>
  summarise(area2d = sum(area, na.rm = TRUE),
            area3d = sum(area3d, na.rm = TRUE)) |>
  write.csv("output/band_area.csv", row.names = F)
