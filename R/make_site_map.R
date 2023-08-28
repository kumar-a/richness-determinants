################################################################################
## Author: Abhishek Kumar
## Affiliation: Panjab University, Chandigarh
## Email: abhikumar.pu@gmail.com
################################################################################

## load the required packages
library(sf)
library(terra)
library(tmap)
library(tidyverse)

#################################
## ----- make an inset map -----
################################

## International spatial boundaries
indsub <- st_read("data/ind_subcont.gpkg", quiet = TRUE) |>
  mutate(NAME = ifelse(NAME %in% c("India", "Nepal", "Bhutan", "China"), 
                       yes = NAME, no = NA))

## Outline for Hindu Kush Himalaya
hkh <- st_read("data/hkh/outline.shp", quiet = TRUE) |>
  mutate(Name = "Hindu Kush Himalaya")

## boundaries for protected areas boundary
mh <- st_read("data/morni.gpkg", quiet = TRUE) |> 
  summarise() |> mutate(Name = "Morni Hills") |> st_transform(4326)
khr <- st_read("data/khol_hi_raitan.gpkg", quiet = TRUE) |>
  filter(Type == "WLS") |> mutate(Name = "KHR WLS")
chail <- st_read("data/chail.gpkg", quiet = TRUE) |> 
  summarise() |> mutate(Name = "Chail")
churdhar <- st_read("data/churdhar.gpkg", quiet = TRUE) |> 
  summarise() |> mutate(Name = "Churdhar")
study_area <- bind_rows(mh, chail, churdhar)

## bounding box
sites_bbox <- st_bbox(study_area) |> st_as_sfc()
inset_bbox <- st_bbox(c(xmin = 72.5, ymin = 26, xmax = 97, ymax = 37), 
                      crs = st_crs(4326)) |> st_as_sfc()

## prepare inset map
inset_map <- tm_shape(hkh, bbox = inset_bbox) + 
  tm_fill(col = "lightyellow2") + 
  tm_text("Name", col = "lightyellow4", size = 0.7) +
  
  tm_shape(indsub, bbox = inset_bbox) + 
  tm_borders(col = "grey", lwd = 0.5) + 
  tm_text("NAME", col = "grey50", size = 0.5,
          xmod = c("India" = -1.25, "Nepal" = 0, "Bhutan" = 0, "China" = -5),
          ymod = c("India" = 3,  "Nepal" = 0, "Bhutan" = 0, "China" = 0)
  ) +
  tm_shape(sites_bbox) + 
  tm_fill(col = "lightpink", alpha = 0.5) + tm_borders(col = "red", lwd = 0.5)


#################################################################
## ----- download and prepare data for main map -----
#################################################################

## bounding box for main map
ssb <- st_bbox(c(xmin = 76.75, ymin = 30.54, xmax = 77.56, ymax = 31.02),
               crs = st_crs(4326)) |> st_as_sfc()

# ## Download and save elevation data
# ssb |> elevatr::get_elev_raster(z = 10) |>
#   rast() |> crop(vect(ssb)) |> writeRaster("output/site_elev.tif")
elev <- rast("output/site_elev.tif")

site_elev <- elev |> crop(vect(study_area)) |>
  mask(vect(study_area))

## Calculate hill shade
slope  <- terrain(elev, "slope",  unit = "radians")
aspect <- terrain(elev, "aspect", unit = "radians")
hs <- shade(slope, aspect)

## state level boundaries
ind1 <- st_read("data/site_states.gpkg", quiet = TRUE) |>
  st_transform(crs = st_crs(4326)) |>
  ## Remove Rajasthan from Text labels
  mutate(STATE = case_when(
    STATE == "Himachal Pradesh" ~"HP",
    STATE == "Punjab" ~"PB"
  )) |>
  st_crop(ssb)

## District level boundaries
ind2 <- st_read("data/site_districts.gpkg", quiet = TRUE) |>
  st_crop(ssb) |>
  mutate(District = ifelse(test = District %in% c("Ambala", "Patiala"), 
                           yes = NA, no = District))

################################################################################

## switch off spherical geometry
sf_use_s2(FALSE) 

## Make the map
main_map <- tm_shape(hs) + 
  tm_raster(palette = "-Greys", legend.show = FALSE) +
  tm_graticules(lines = FALSE, labels.size = 0.75) +
  
  tm_shape(ind2) + 
  tm_fill(col = "#ffffe5", alpha = 0.5) +
  tm_borders(col = "grey40", lwd = 0.5) + 
  tm_text("District", col = "grey30", size = 0.7,
          xmod = c(Chandigarh = 0.15, Shimla = -8, Sirmaur = -2.5, Solan = 2, 
                   NA, Panchkula = 0.75, NA, "SAS Nagar" = 0.4), 
          ymod = c(Chandigarh = 0, Shimla = 3.75, Sirmaur = 2.5, Solan = 0, 
                   NA, Panchkula = -4.5, NA, "SAS Nagar" = -0.5)) +
  
  tm_shape(ind1, bbox = st_bbox(ssb)) + 
  tm_borders(col = "grey20", lwd = 0.6) +
  
  tm_shape(site_elev) + 
  tm_raster(palette = terrain.colors(8, rev = FALSE), alpha = 0.5,
            breaks = c(-Inf, seq(500, 3000, 500), Inf),
            title = "Elevation (m)", legend.reverse = TRUE) +
  
  tm_shape(study_area) + 
  tm_borders(col = "#004529", lwd = 1.25) +
  tm_text("Name", size = 0.9, col = "#004529", shadow = TRUE,
          xmod = c("Morni Hills" = 0.2, Chail = 0, Churdhar = 0),
          ymod = c("Morni Hills" = 1, Chail = 0.1, Churdhar = 0.5)) +
  
  tm_add_legend(type = "fill", labels = "Study sites", col = NA,
                border.col = "#004529", border.lwd = 1.25) +
  
  tm_compass(position = c(0.99, 0.99), just = c("right", "top"), 
             bg.color = "white", bg.alpha = 0.5) +
  tm_layout(legend.bg.color = "grey90", legend.bg.alpha = 0.9,
            legend.position = c(0.01, 0.99), legend.just = c(0, 1),
            legend.text.size = 0.75, legend.title.size = 1,
            inner.margins = 0)


# ## arrange and save maps
myvp <- grid::viewport(
  x = 0.999, y = 0.11, just = c("right", "bottom"),
  width = unit(2.75, "inches"), height = unit((37-26)/(97-72.5)*2.75, "inches")
)

# ## save map to local disk
tmap_save(main_map, filename = "figs/site_map.pdf", insets_tm = inset_map,
          insets_vp = myvp, height = 5, width = 7, units = "in")
tmap_save(main_map, filename = "figs/site_map.png", insets_tm = inset_map,
          insets_vp = myvp, height = 5, width = 7, units = "in", dpi = 600)
