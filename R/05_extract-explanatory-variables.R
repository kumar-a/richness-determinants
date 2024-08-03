################################################################################
## Author: Abhishek Kumar
## Affiliation: Panjab University, Chandigarh
## Email: abhikumar.pu@gmail.com
################################################################################

## load required packages
library(sf)
library(terra)
library(tidyverse)

################################################################################
## ----- function to extract data from raster for each elevational band -----
################################################################################

## shp: is the spatial boundary of study site
## xraster: raster from which data to be extracted
## elev_raster: raster with elevation data
## site: name of site
## band.size: the size of each elevational band, defaults to 100

rast2band <- function(shp, xraster, elev_raster, site, band.size = 100){
  
  ## crop and mask the raster dataset
  data_raster <- xraster |> crop(vect(shp)) |> mask(vect(shp))
  
  ## ----- create elevational bands -----
  
  ## resample, crop, mask elevation to site boundary
  elev_mask <- elev_raster |> resample(data_raster) |>
    crop(vect(shp)) |> mask(vect(shp))
  
  ## minimum and maximum elevation values
  min_elev <- minmax(elev_mask)[1] |> round(-2)
  max_elev <- minmax(elev_mask)[2] |> round(-2)
  
  ## round min and max values
  elev_mask[elev_mask < min_elev] <- min_elev
  elev_mask[elev_mask > max_elev] <- max_elev
  
  ## reclassification matrix
  rcl <- data.frame(from = seq(min_elev, max_elev - band.size, band.size),
                    to = seq(min_elev + band.size, max_elev, band.size),
                    Elevation = seq(min_elev + band.size, max_elev, band.size)) |>
    as.matrix()
  
  ## reclassify elevation raster to elevation bands
  elev100 <- elev_mask |> classify(rcl)
  names(elev100) <- "elevation"
  
  ## ----- calculate data for each zone -----
  r <- zonal(data_raster, elev100)
  
  ## add site column
  r$site <- site
  
  return(r)
}

################################################################################
## ----- Download elevation data for each site -----
################################################################################

## boundary for Morni Hills
morni <- st_read("data/morni.gpkg", quiet = TRUE) |> 
  summarise() |> 
  mutate(Name = "Morni") |> 
  st_transform(4326)

# ## download elevation data for Morni Hills
# morni |> st_bbox() |> st_as_sfc() |>
#   ## download elevation
#   elevatr::get_elev_raster(z = 12) |>
#   ## convert to spatRaster and crop to site extent
#   rast() |> crop(vect(morni)) |> 
#   writeRaster("output/morni_elev.tif")

## read elevation for Morni Hills
morni_elev <- rast("output/morni_elev.tif")



## boundary for Chail WLS
chail <- st_read("data/chail.gpkg", quiet = TRUE) |> 
  summarise() |> 
  mutate(Name = "Chail")

# ## bounding box to fit legend (if required) Chail WLS
# chail_bb <- st_bbox(c(xmin = 77.10, ymin = 30.88, xmax = 77.28, ymax = 31.02), 
#                     crs = st_crs(4326)) |> st_as_sfc()
# ## download elevation data for Chail WLS
# chail |> st_bbox() |> st_as_sfc() |>
#   ## download elevation
#   elevatr::get_elev_raster(z = 12) |>
#   ## convert to spatRaster and crop to site extent
#   rast() |> crop(vect(chail_bb)) |> 
#   writeRaster("output/chail_elev.tif")

## read elevation for Chail WLS
chail_elev <- rast("output/chail_elev.tif")



## boundary for Churdhar WLS
churdhar <- st_read("data/churdhar.gpkg", quiet = TRUE) |> 
  summarise() |> 
  mutate(Name = "Churdhar")

# ## bounding box to fit legend (if required) Churdhar WLS
# churdhar_bb <- st_bbox(c(xmin = 77.36, ymin = 30.78, xmax = 77.56, ymax = 30.94),
#                crs = st_crs(4326)) |> st_as_sfc()
# ## download elevation data for Churdhar WLS
# churdhar |> st_bbox() |> st_as_sfc() |>
#   ## download elevation
#   elevatr::get_elev_raster(z = 12) |>
#   ## convert to spatRaster and crop to site extent
#   rast() |> crop(vect(churdhar_bb)) |> 
#   writeRaster("output/churdhar_elev.tif")

## read elevation for Churdhar WLS
churdhar_elev <- rast("output/churdhar_elev.tif")


## boundary for all sites combined
site_all <- bind_rows(morni, chail, churdhar)

## elevation for all sites
site_elev <- rast("output/site_elev.tif") |>
  crop(vect(site_all)) |> mask(vect(site_all))


################################################################################
## ----- extract explanatory variables -----
################################################################################

## reference raster for resampling to 30 arc sec (~1 km)
## CHELSA climate dataset -----
chelsa_bio <- rast("data/site_bio_chelsa.tif") |> 
  ## subset to MAT (bio1), TSE (bio4), MAP (bio12), PSE (bio15)
  subset(c(1, 4, 12, 15))

## rename the layers
names(chelsa_bio) <- c("MAT", "TSE", "MAP", "PSE")

## bind and save climate data for all sites
band_climate_chelsa <- bind_rows(
  rast2band(morni,    chelsa_bio, morni_elev,    site = "Morni"),
  rast2band(chail,    chelsa_bio, chail_elev,    site = "Chail"),
  rast2band(churdhar, chelsa_bio, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, chelsa_bio, site_elev,     site = "All")
)

## CHELSA NPP for sites -----
chelsa_npp <- rast("data/site_npp_chelsa.tif")
names(chelsa_npp) <- "NPP"
  
## bind and save NPP data for all sites
band_npp_chelsa <- bind_rows(
  rast2band(morni,    chelsa_npp, morni_elev,    site = "Morni"),
  rast2band(chail,    chelsa_npp, chail_elev,    site = "Chail"),
  rast2band(churdhar, chelsa_npp, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, chelsa_npp, site_elev,     site = "All")
)

## SoilGrids SOC for sites -----
soilgrid_soc <- rast("data/site_soc_soilgrid.tif")
names(soilgrid_soc) <- "SOC"

## bind and save NPP data for all sites
band_soc_soilgrid <- bind_rows(
  rast2band(morni,    soilgrid_soc, morni_elev,    site = "Morni"),
  rast2band(chail,    soilgrid_soc, chail_elev,    site = "Chail"),
  rast2band(churdhar, soilgrid_soc, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, soilgrid_soc, site_elev,     site = "All")
)

## CGIAR-CSI AET for sites -----
cgiar_aet <- rast("data/site_aet_cgiar.tif")
names(cgiar_aet) <- "AET"

## bind and save AET data for all sites
band_aet_cgiar <- bind_rows(
  rast2band(morni,    cgiar_aet, morni_elev,    site = "Morni"),
  rast2band(chail,    cgiar_aet, chail_elev,    site = "Chail"),
  rast2band(churdhar, cgiar_aet, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, cgiar_aet, site_elev,     site = "All")
)

## CGIAR-CSI PET for sites -----
cgiar_pet <- rast("data/site_pet_cgiar.tif")
names(cgiar_pet) <- "PET"

## bind and save PET data for all sites
band_pet_cgiar <- bind_rows(
  rast2band(morni,    cgiar_pet, morni_elev,    site = "Morni"),
  rast2band(chail,    cgiar_pet, chail_elev,    site = "Chail"),
  rast2band(churdhar, cgiar_pet, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, cgiar_pet, site_elev,     site = "All")
)

## EarthEnv EVI Homogeneity -----
evi_homo <- rast("data/site_evihomo_earthenv.tif")
names(evi_homo) <- "EHM"

## bind and save PET data for all sites
band_ehm_earthenv <- bind_rows(
  rast2band(morni,    evi_homo, morni_elev,    site = "Morni"),
  rast2band(chail,    evi_homo, chail_elev,    site = "Chail"),
  rast2band(churdhar, evi_homo, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, evi_homo, site_elev,     site = "All")
)

## EarthEnv Terrain Ruggedness Index (TRI) -----
hetero_tri <- rast("data/site_tri_earthenv.tif")
names(hetero_tri) <- "TRI"

## bind and save PET data for all sites
band_tri_earthenv <- bind_rows(
  rast2band(morni,    hetero_tri, morni_elev,    site = "Morni"),
  rast2band(chail,    hetero_tri, chail_elev,    site = "Chail"),
  rast2band(churdhar, hetero_tri, churdhar_elev, site = "Churdhar"),
  rast2band(site_all, hetero_tri, site_elev,     site = "All")
)

read.csv("output/band_richness.csv") |>
  select(site, richness, elevation) |>
  left_join(band_climate_chelsa) |>
  left_join(band_npp_chelsa) |>
  left_join(band_soc_soilgrid) |>
  left_join(band_aet_cgiar) |>
  left_join(band_pet_cgiar) |>
  left_join(band_ehm_earthenv) |>
  left_join(band_tri_earthenv) |>
  mutate(WDF = PET - AET) |>
  rename("S" = richness, "ELE" = elevation) |>
  write.csv("output/site_env.csv", row.names = FALSE)
