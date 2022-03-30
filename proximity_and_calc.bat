:: Script to generate proximity rasters and reclassify them. Final calculation steps overlay all rasters and determine areas that do not meet enough criteria.
:: Author: Nel Nußberger
:: Last edited: 17.03.2022

:: generate proximity rasters for all layers

:: user area
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_user_area.tif proxim_user_area.tif

:: elec points
gdal_proximity -srcband 1 -distunits GEO -maxdist 150.0 -ot Float32 -of GTiff rast_elec.tif proxim_elec.tif

:: sanitary facilities
gdal_proximity -srcband 1 -distunits GEO -maxdist 150.0 -ot Float32 -of GTiff rast_sani.tif proxim_sani.tif

:: shelters
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_shelters.tif proxim_shelters.tif

::supermarkets
gdal_proximity -srcband 1 -distunits GEO -maxdist 5000.0 -ot Float32 -of GTiff rast_super.tif proxim_super.tif

:: train stations
gdal_proximity -srcband 1 -distunits GEO -maxdist 2000.0 -ot Float32 -of GTiff rast_trainstations.tif proxim_trainstations.tif

:: water points
gdal_proximity -srcband 1 -distunits GEO -maxdist 500.0 -ot Float32 -of GTiff rast_water_point.tif proxim_water_point.tif



:: reclassify to be able to calculate

:: user area
gdal_calc -A proxim_user_area.tif --outfile=reclass_proxim_user_area.tif --calc="100*(A<=100)+50*(A>100)*(A<=250)+1*(A>250)"

:: elec points
gdal_calc -A proxim_elec.tif --outfile=reclass_proxim_elec.tif --calc="25*(A<=50)+10*(A>50)*(A<=150)+1*(A>150)"

:: sanitary facilites
gdal_calc -A proxim_sani.tif --outfile=reclass_proxim_sani.tif --calc="25*(A<=50)+10*(A>50)*(A<=150)+1*(A>150)"

:: shelters
gdal_calc -A proxim_shelters.tif --outfile=reclass_proxim_shelters.tif --calc="25*(A<=100)+10*(A>100)*(A<=250)+1*(A>250)"

:: supermarkets
gdal_calc -A proxim_super.tif --outfile=reclass_proxim_super.tif --calc="50*(A<=2500)+25*(A>2500)*(A<=5000)+1*(A>5000)"

:: train stations
gdal_calc -A proxim_trainstations.tif --outfile=reclass_proxim_trainstations.tif --calc="50*(A<=1000)+25*(A>1000)*(A<=2000)+1*(A>2000)"

:: water points
gdal_calc -A proxim_water_point.tif --outfile=reclass_proxim_water_point.tif --calc="25*(A<=250)+10*(A>250)*(A<=500)+1*(A>500)"


:: overlay all rasters to generate a single raster containing all information
gdal_calc -A reclass_proxim_user_area.tif -B reclass_proxim_elec.tif -C reclass_proxim_sani.tif -D reclass_proxim_shelters.tif -E reclass_proxim_super.tif -F reclass_proxim_trainstations.tif -G reclass_proxim_water_point.tif --extent=union --outfile=proxim_final_calc.tif --calc="A+B+C+D+E+F+G"

:: final calculation step that determines areas with low fulfillment of requirements
gdal_calc -A proxim_final_calc.tif --outfile=rastermap.tif --calc="(A>=150)*A"