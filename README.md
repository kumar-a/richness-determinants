# Determinants of Plant Species Richness along Elevational Gradients: Insights with Climate, Energy and Water-Energy Dynamics
**Authors:** [Abhishek Kumar](https://akumar.netlify.app/)<sup>#</sup>, [Meenu Patil](https://www.researchgate.net/profile/Meenu-Patil), [Pardeep Kumar](https://www.researchgate.net/profile/Pardeep-Kumar-22), [Anand Narain Singh](https://www.researchgate.net/profile/Anand-Singh-15)\*   
**Affiliation:** *Soil Ecosystem and Restoration Ecology Lab, Department of Botany, Panjab University, Chandigarh 160014, India*  
\*Corresponding author: dranand1212@gmail.com; ansingh@pu.ac.in  
<sup>#</sup>Maintainer: abhikumar.pu@gmail.com

## Directory structure

```
.
  |- data
    |- hkh
    |- chail_plants.csv
    |- chail.gpkg
    |- churdhar_plants.csv
    |- churdhar.gpkg
    |- ecs22945-sup-0004-datas1.csv
    |- khol_hi_raitan.gpkg
    |- morni_plants.csv
    |- morni.gpkg
    |- site_aet_cgiar.tif
    |- site_bio_chelsa.tif
    |- site_districts.gpkg
    |- site_evihomo_earthenv.tif
    |- site_npp_chelsa.tif
    |- site_pet_cgiar.tif
    |- site_soc_soilgrid.tif
    |- site_states.gpkg
    |- site_tri_earthenv.tif
  |- figs
    |- bmod_sem.pdf
    |- hypothetical_sem.pdf
    |- site_map.pdf
  |- gv
    |- bmod_sem.gv
    |- hypothetical_sem.gv
  |- output
    |- 0417447-210914110416597.zip
    |- band_area.csv
    |- band_richness.csv
    |- chail_elev.tif
    |- churdhar_elev.tif
    |- morni_elev.tif
    |- site_elev.tif
    |- site_env.csv
    |- site_plants_wcvp.csv
    |- site_spec_elev.csv
    |- top_mod_comparison.csv
  |- R
    |- calculate_band_area.R
    |- calculate_richness.R
    |- compare_top_model.R
    |- extract_climate.R
    |- extract_explanatory_variables.R
    |- get_elevation_ranges.R
    |- make_site_map.R
    |- standardise_plant_names.R
  |- apa7.csl
  |- credit_author.csv
  |- index.qmd
  |- README.md
  |- refs.bib
  |- richness-determinants.Rproj
```

## Description of primary data files

| File name | Description |  
|-----------|-------------|
| [hkh](/data/hkh/) | Spatial boundary of Hindu Kush Himalayas (HKH) obtained from ICIMOD ([2008](https://www.icimod.org/)) |
| [chail_plants.csv](/data/chail_plants.csv) | Recorded plant species from literature survey for Chail Wildlife Sanctuary |
| [chail.gpkg](/data/chail.gpkg) | Digitised spatial boundary for Chail Wildlife Sanctuary |
| [churdhar_plants.csv](/data/churdhar_plants.csv) | Recorded plant species from literature survey for Churdhar Wildlife Sanctuary |
| [churdhar.gpkg](/data/chail.gpkg) | Digitised spatial boundary for Churdhar Wildlife Sanctuary |
| [ecs22945-sup-0004-datas1.csv](/data/ecs22945-sup-0004-datas1.csv) | Additional species distribution data from Rana, Price, & Qian ([2019](https://doi.org/10.1002/ecs2.2945)) |
| [khol_hi_raitan.gpkg](/data/khol_hi_raitan.gpkg) | Digitised spatial boundary for Khol Hi Raitan Wildlife Sanctuary |
| [morni_plants.csv](/data/morni_plants.csv) | Recorded plant species from literature survey for Morni Hills |
| [morni.gpkg](/data/morni.gpkg) | Digitised spatial boundary for Morni Hills |
| [site_aet_cgiar.tif](/data/site_aet_cgiar.tif) | Cropped actual evapotranspiration (AET) data obtained from Trabucco & Zomer ([2019](https://doi.org/10.6084/m9.figshare.7707605.v3)) |
| [site_bio_chelsa.tif](/data/site_bio_chelsa.tif) | Cropped bioclimatic variables data obtained from Karger et al. ([2017](https://doi.org/10.1038/sdata.2017.122)) |
| [site_districts.gpkg](/data/site_districts.gpkg) | Spatial boundaries for Indian districts sharing the bounding box for selected study sites in the Himalayas |
| [site_evihomo_earthenv.tif](/data/site_evihomo_earthenv.tif) | Cropped EVI homogeneity index data obtained from Tuanmu & Jetz ([2015](https://doi.org/10.1111/geb.12365)) |
| [site_npp_chelsa.tif](/data/site_npp_chelsa.tif) | Cropped net primary productivity (NPP) data obtained from Karger et al. ([2017](https://doi.org/10.1038/sdata.2017.122)) |
| [site_pet_cgiar.tif](/data/site_pet_cgiar.tif) | Cropped potential evapotranspiration (PET) data obtained from Zomer et al. ([2022](https://doi.org/10.1038/s41597-022-01493-1)) |
| [site_soc_soilgrid.tif](/data/site_soc_soilgrid.tif) | Cropped soil organic carbon (SOC) data obtained from Hengl et al. ([2017](https://doi.org/10.1371/journal.pone.0169748)) |
| [site_states.gpkg](/data/site_states.gpkg) | Spatial boundaries for north-western Indian States covering the study sites in the Western Himalayas |
| [site_tri_earthenv.gpkg](/data/site_tri_earthenv.gpkg) | Cropped terrain ruggedness index (TRI) data obtained from Amatulli et al. ([2018](https://doi.org/10.1038/sdata.2018.40)) |

## Description of figures

| File name | Description |  
|-----------|-------------|
| [bmod_sem.pdf](/figs/bmod_sem.pdf) | Figure depicted final best SEM model for species richness |
| [hypothetical_sem.pdf](/figs/hypothetical_sem.pdf) | A priori hypothetical conceptual model for determinants of species richness |
| [site_map.pdf](/figs/site_map.pdf) | Map showing the location and elevation profile of study sites. This map was prepared using the [make_site_map.R](/R/make_site_map.R) script |

## Description of [Graphviz](https://graphviz.org/) scripts

| File name | Description |  
|-----------|-------------|
| [bmod_sem.gv](/gv/bmod_sem.gv) | Graphviz script for final best path model for determinants of species richness |
| [hypothetical_sem.gv](/gv/hypothetical_sem.gv) | Graphviz script for the priori hypothetical conceptual model for determinants of species richness |

## Description of files derived using `R` 

| File name | Description |  
|-----------|-------------|
| [0417447-210914110416597.zip](/output/0417447-210914110416597.zip) | Species distribution dataset (Rana & Rawat [2017](https://doi.org/10.3390/data2040036), [2019](https://doi.org/10.15468/zdeuix)) downloaded from [GBIF](https://www.gbif.org/) via `rgbif` package |  
| [band_area.csv](/output/band_area.csv) | Calculated planar and slope-corrected area for each elevational band using the [calculate_band_area.R](/R/calculate_band_area.R) script |
| [band_richness.csv](/output/band_richness.csv) | Estimated species richness for 100-m elevational bands for each site using the [calculate_richness.R](/R/calculate_richness.R) script |
| [chail_elev.tif](/output/chail_elev.tif) | Cropped elevation data for Chail WLS downloaded using the [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) script |
| [churdhar_elev.tif](/output/churdhar_elev.tif) | Cropped elevation data for Churdhar WLS downloaded using the [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) script |
| [morni_elev.tif](/output/morni_elev.tif) | Cropped elevation data for Morni Hills downloaded using the [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) script |
| [site_elev.tif](/output/site_elev.tif) | Cropped elevation data for study area downloaded using the [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) script |
| [site_env.tif](/output/site_env.tif) | Prepared dataset with species richness and explanatory variables for each site processed using the [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) script |
| [site_plants_wcvp.csv](/output/site_plants_wcvp.csv) | Combined species check-list with botanical names standardised according to World Checklist of Vascular Plants (WCVP, Govaerts et al., [2021](https://doi.org/10.1038/s41597-021-00997-6)) using the [standardise_plant_names.R](/R/standardise_plant_names.R) script |
| [site_spec_elev.csv](/output/site_spec_elev.csv) | Finally prepared dataset for standardised unique species and their elevational ranges for selected study sites using the [get_elevation_ranges.R](/R/get_elevation_ranges.R) script |
| [top_mod_comparison.csv](/output/top_mod_comparison.csv) | Comparison of identified top model with previously proposed models of species richness using the [compare_top_model.R](/R/compare_top_model.R) script |

## Description of `R` scripts

| File name | Description |  
|-----------|-------------|
| [calculate_band_area.R](/R/calculate_band_area.R) | `R` codes for calculating the planar and slope-corrected area for each 100-m elevational band for each study site |
| [calculate_richness.R](/R/calculate_richness.R) | `R` codes with function used to calculate species richness from compiled dataset for each study site |
| [compare_top_model.R](/R/compare_top_model.R) | |
| [extract_climate.R](/R/extract_climate.R) | `R` script to extract climate data from WorldClim2 database (Fick & Hijmans [2017](https://doi.org/10.1002/joc.5086)) and process to prepare Walter-Leith Diagrams for study sites |
| [extract_explanatory_variables.R](/R/extract_explanatory_variables.R) | `R` codes to extract mean values of each explanatory variable for each site |
| [get_elevation_ranges.R](/R/get_elevation_ranges.R) | `R` codes to retrieve the species elevational ranges from published database (Rana & Rawat [2017](https://doi.org/10.3390/data2040036), [2019](https://doi.org/10.15468/zdeuix)) |
| [make_site_map.R](/R/make_site_map.R) | `R` codes to prepare the map for study sites ([site_map.pdf](/figs/site_map.pdf)) |
| [standardise_plant_names.R](/R/standardise_plant_names.R) | `R` codes to standardise botanical names according to WCVP (Govaerts et al., [2021](https://doi.org/10.1038/s41597-021-00997-6)). The standardised botanical names are saved as [site_plants_wcvp.csv](/output/site_plants_wcvp.csv) |

## Description of other files

| File name | Description |  
|-----------|-------------|
| [apa7.csl](/apa7.csl) | Citation Style Language (CSL) citation style for American Psychological Association (APA) 7th edition |
| [credit_author.csv](/credit_author.csv) | Documentation of each authors' contribution in CRediT (Contributor Roles Taxonomy) author statement |
| [index.qmd](/index.qmd) | Quarto markdown file with embedded `R` codes to reproduce the initial draft of manuscript |
| [refs.bib](/refs.bib) | Bibliographic entries for literature cited in the manuscript |
| [richness-determinants.Rproj](/richness-determinants.Rproj) | `R` project file |

## Codebook for [chail_plants.csv](/data/chail_plants.csv), [chur_plants.csv](/data/chur_plants.csv) and [morni_plants.csv](/data/morni_plants.csv)

| Column      | Description                                                       |
|-------------|-------------------------------------------------------------------|
| given_name  | Botanical name given in the published study |
| powo_taxa   | Accepted botanical name by *Plants of World Online* ([POWO](https://powo.science.kew.org/)) |
| powo_author | Accepted botanical name authorship by *Plants of World Online* ([POWO](https://powo.science.kew.org/)) |
| powo_dist   | Distribution status (Introduced vs. Native) of plant according to *Plants of World Online* ([POWO](https://powo.science.kew.org/)) |

All other columns refer to citation keys for studies identified through literature survey, i.e., Bhardwaj2017[^1], Champion1968[^2], eFI2022[^3], FOI2022[^4], Kumar2013[^5], Choudhary2007[^6], Choudhary2012[^7], Gupta1998[^8], Radha2019[^9], Subramani2014[^10], Thakur2021a[^11], Balkrishna2018a[^12], Balkrishna2018b[^13], Dhiman2020[^14], Dhiman2021[^15], Singh2014[^16]

## Codebook for [band_area.csv](/output/band_area.csv)

| Column    | Description                                                       |
|-----------|-------------------------------------------------------------------|
| elevation | Upper elevation of each 100-m elevational band in metres |
| site      | Name of site for which the MDE null model was run |
| area2d    | total planar area in km^2^ for each elevational band  |
| area3d    | total slope-corrected area in km^2^ for each elevational band  |


## Codebook for [band_richness.csv](/output/band_richness.csv)

| Column    | Description                                                       |
|-----------|-------------------------------------------------------------------|
| elevation | Upper elevation of each 100-m elevational band in metres |
| richness  | Estimated species richness for each 100-m elevational band for selected sites |
| site      | Name of site for which the elevational species richness was estimated |

## Codebook for [site_env.csv](/output/site_env.csv)

| Column | Description                                                       |
|--------|-------------------------------------------------------------------|
| site   | Name of site for which the elevational species richness was estimated |
| S      | Estimated species richness for each 100-m elevational band for selected sites |
| ELE    | Upper elevation of each 100-m elevational band in metres |
| MAT    | Mean annual temperature (bio1) of each 100-m elevational band in &deg;C |
| TSE    | Temperature seasonality (bio4) of each 100-m elevational band in &deg;C/100 |
| MAP    | Mean annual precipitation (bio12) of each 100-m elevational band in kg m<sup>-2</sup> yr<sup>-1</sup> |
| PSE    | Precipitation seasonality (bio15) of each 100-m elevational band in kg m<sup>-2</sup> |
| NPP    | Net primary productivity (NPP) of each 100-m elevational band in g C m<sup>−2</sup> yr<sup>−1</sup> |
| SOC    | Soil organic carbon (SOC) of each 100-m elevational band in dg/kg (= 10 &times; g/kg) |
| AET    | Actual evapotranspiration (AET) of each 100-m elevational band in mm |
| PET    | Potential evapotranspiration (PET) of each 100-m elevational band in mm |
| EHM    | EVI homogeneity (EHM) of each 100-m elevational band |
| TRI    | Terrain ruggedness index (TRI) of each 100-m elevational band in meters |
| WDF    | Water deficit (WDF) of each 100-m elevational band in mm |

## Codebook for [site_plants_wcvp.csv](/output/site_plants_wcvp.csv)

| Column    | Description                                                       |
|-----------|-------------------------------------------------------------------|
| taxon_name | Accepted botanical names standardised according to World Checklist of Vascular Plants (WCVP) |
| taxon_authors | Accepted botanical authorship standardised according to World Checklist of Vascular Plants (WCVP) |
| genus | Accepted botanical genus epithet standardised according to World Checklist of Vascular Plants (WCVP) |
| family | Accepted family of plant species standardised according to World Checklist of Vascular Plants (WCVP), which follows Angiosperm Phylogeny Group (APG) classification |
| powo_dist | Distribution status (Introduced vs. Native) of plant according to World Checklist of Vascular Plants (WCVP) |
| lifeform_description | Lifeform description of selected plant species according to World Checklist of Vascular Plants (WCVP) |
| climate_description | Climate description of selected plant species according to World Checklist of Vascular Plants (WCVP) |
| Morni | Short for Morni Hills |
| Chail | Short for Chail Wildlife Sanctuary |
| Churdhar | Short for Churdhar Wildlife Sanctuary |

## Codebook for [site_spec_elev.csv](/output/site_spec_elev.csv)

| Column    | Description                                                       |
|-----------|-------------------------------------------------------------------|
| taxon_name | Accepted botanical names standardised according to World Checklist of Vascular Plants (WCVP) |
| LL | Lower elevational limit (in meters) of the species in Himalayas |
| UL | Upper elevational limit (in meters) of the species in Himalayas |

## Codebook for [top_mod_comparison.csv](/output/top_mod_comparison.csv)

| Column  | Description                                                       |
|---------|-------------------------------------------------------------------|
| Site    | Name of site for which the model was compared |
| Model   | Species richness model in y ~ x form |
| logLik  | log-likelihood of the model |
| AICc    | corrected Akaike's Information Criteria |
| daicc   | difference in corrected Akaike's Information Criteria from the top model |
| dev.adj | adjusted deviance-squared for model |

## References

- Amatulli, G., Domisch, S., Tuanmu, M.-N., Parmentier, B., Ranipeta, A., Malczyk, J., & Jetz, W. (2018). A suite of global, cross-scale topographic variables for environmental and biodiversity modeling. *Scientific Data, 5*, 180040. <https://doi.org/10.1038/sdata.2018.40>

- Fick, S. E., & Hijmans, R. J. (2017). WorldClim 2: New 1-km spatial resolution climate surfaces for global land areas. *International Journal of Climatology, 37*(12), 4302–4315. <https://doi.org/10.1002/joc.5086>


- Govaerts, R., Lughadha, E. N., Black, N., Turner, R., & Paton, A. (2021). The World Checklist of Vascular Plants, a continuously updated resource for exploring global plant diversity. *Scientific Data, 8*(1), 215. <https://doi.org/10.1038/s41597-021-00997-6>

- Hengl, T., Jesus, J. M. de, Heuvelink, G. B. M., Gonzalez, M. R., Kilibarda, M., Blagotić, A., Shangguan, W., Wright, M. N., Geng, X., Bauer-Marschallinger, B., Guevara, M. A., Vargas, R., MacMillan, R. A., Batjes, N. H., Leenaars, J. G. B., Ribeiro, E., Wheeler, I., Mantel, S., & Kempen, B. (2017). SoilGrids250m: Global gridded soil information based on machine learning. *PLoS ONE, 12*(2), e0169748. <https://doi.org/10.1371/journal.pone.0169748>

- ICIMOD (2008). Outline Boundary of Hindu Kush Himalayan (HKH) Region. <http://rds.icimod.org/>

- Karger, D. N., Conrad, O., Böhner, J., Kawohl, T., Kreft, H., Soria-Auza, R. W., Zimmermann, N. E., Linder, H. P., & Kessler, M. (2017). Climatologies at high resolution for the earth’s land surface areas. *Scientific Data, 4*, 170122. <https://doi.org/10.1038/sdata.2017.122>

- Rana, S. K., Price, T. D., & Qian, H. (2019). Plant species richness across the Himalaya driven by evolutionary history and current climate. *Ecosphere, 10*(11), e02945. <https://doi.org/10.1002/ecs2.2945>

- Rana, S. K., & Rawat, G. S. (2017). Database of Himalayan plants based on published floras during a century. *Data, 2*(4), 36. <https://doi.org/10.3390/data2040036>

- Rana, S. K., & Rawat, G. S. (2019). *Database of vascular plants of Himalaya*. Version 1.6. Dehradun: Wildlife Institute of India. <https://doi.org/10.15468/zdeuix>

- Trabucco, A., & Zomer, R. J. (2019). *Global high-resolution soil-water balance (version 3)*. CGIAR Consortium for Spatial Information. <https://doi.org/10.6084/m9.figshare.7707605.v3>

- Tuanmu, M.-N., & Jetz, W. (2015). A global, remote sensing-based characterization of terrestrial habitat heterogeneity for biodiversity and ecosystem modelling. *Global Ecology and Biogeography, 24*(11), 1329–1339. <https://doi.org/10.1111/geb.12365>

- Zomer, R. J., Xu, J., & Trabucco, A. (2022). Version 3 of the global aridity index and potential evapotranspiration database. *Scientific Data, 9*, 409. <https://doi.org/10.1038/s41597-022-01493-1>

[^1]: Bhardwaj, A. (2017). *Study on dynamics of plant bioresources in Chail wildlife sanctuary of Himachal Pradesh* (PhD thesis, Forest Research Institute (Deemed) University; p. 342). Forest Research Institute (Deemed) University, Dehradun. Retrieved from <http://hdl.handle.net/10603/175719>

[^2]: Champion, H. G., & Seth, S. K. (1968). *A revised survey of the forest types of India* (p. 404). Delhi: Government of India.

[^3]: eFI. (2022). *eFlora of India: Database of plants of Indian subcontinent*. Retrieved from <https://efloraofindia.com/>

[^4]: FOI. (2022). *Flowers of India*. Retrieved from <http://www.flowersofindia.net/>

[^5]: Kumar, R. (2013). *Studies on plant biodiversity of Chail wildlife sanctuary in Himachal Pradesh* (Master’s thesis, Dr Yashwant Singh Parmar University of Horticulture and Forestry; p. 119). Dr Yashwant Singh Parmar University of Horticulture and Forestry, Solan. Retrieved from <http://krishikosh.egranth.ac.in/handle/1/91126>

[^6]: Choudhary, A. K., Punam, Sharma, P. K., & Chandel, S. (2007). Study on the physiography and biodiversity of Churdhar wildlife sanctuary of Himachal Himalayas, India. *Tigerpaper, 34*, 27–32.

[^7]: Choudhary, R. K., & Lee, J. (2012). A floristic reconnaissance of Churdhar wildlife sanctuary of Himachal Pradesh, India. *Manthan, 13*, 2–12.

[^8]: Gupta, H. (1998). *Comparative studies on the medicinal and aromatic flora of Churdhar and Rohtang areas of Himachal Pradesh* (Master’s thesis, Dr Yashwant Singh Parmar University of Horticulture and Forestry; p. 228). Dr Yashwant Singh Parmar University of Horticulture and Forestry, Solan. Retrieved from <http://krishikosh.egranth.ac.in/handle/1/5810135063>

[^9]: Radha, Puri, S., Chandel, K., Pundir, A., Thakur, M. S., Chauhan, B., … Kumar, S. (2019). Diversity of ethnomedicinal plants in Churdhar wildlife sanctuary of district Sirmour of Himachal Pradesh, India. *Journal of Applied Pharmaceutical Science, 9*(11), 48–53. <https://doi.org/10.7324/japs.2019.91106>

[^10]: Subramani, S. P., Kapoor, K. S., & Goraya, G. S. (2014). Additions to the floral wealth of Sirmaur district, Himachal Pradesh from Churdhar wildlife sanctuary. *Journal of Threatened Taxa, 6*(11), 6427–6452. <https://doi.org/10.11609/jott.o2845.6427-52>

[^11]: Thakur, U., Bisht, N. S., Kumar, M., & Kumar, A. (2021). Influence of altitude on diversity and distribution pattern of trees in Himalayan temperate forests of Churdhar wildlife sanctuary, India. *Water, Air, & Soil Pollution, 232*, 205. <https://doi.org/10.1007/s11270-021-05162-8>

[^12]: Balkrishna, A., Srivastava, A., Shukla, B., Mishra, R., & Joshi, B. (2018). Medicinal plants of Morni Hills, Shivalik Range, Panchkula, Haryana. *Journal of Non-Timber Forest Products, 25*(1), 1–14. <https://doi.org/10.54207/bsmps2000-2018-ir3j0n>

[^13]: Balkrishna, A., Joshi, B., Srivastava, A., & Shukla, B. (2018). Phyto-resources of Morni Hills, Panchkula, Haryana. *Journal of Non-Timber Forest Products, 25*(2), 91–98. <https://doi.org/10.54207/bsmps2000-2018-p430i5>

[^14]: Dhiman, H., Saharan, H., & Jakhar, S. (2020). Floristic diversity assessment and vegetation analysis of the upper altitudinal ranges of Morni Hills, Panchkula, Haryana, India. *Asian Journal of Conservation Biology, 9*(1), 134–142.

[^15]: Dhiman, H., Saharan, H., & Jakhar, S. (2021). Study of invasive plants in tropical dry deciduous forests – biological spectrum, phenology, and diversity. *Forestry Studies, 74*(1), 58–71. <https://doi.org/10.2478/fsmu-2021-0004>

[^16]: Singh, N., & Vashistha, B. D. (2014). Flowering plant diversity and ethnobotany of Morni Hills, Siwalik Range, Haryana, India. *International Journal of Pharma and Bio Sciences, 5*(2), B214–B222.
