:: script to reproject layers into UTM 32N, rasterize, generate proximity rasters, reclassify and calculate final raster

@echo OFF

echo Enter EPSG code : 
set /p user_crs=
echo The CRS has been set to EPSG %user_crs%


:: user_area 
ogr2ogr -t_srs EPSG:%user_crs% reproj_user_area.geojson user_area.geojson

:: water_point 
ogr2ogr -t_srs EPSG:%user_crs% reproj_water_point.geojson water_point.geojson

:: supermarkets 
ogr2ogr -t_srs EPSG:%user_crs% reproj_super.geojson supermarkets.geojson

:: shelters
ogr2ogr -t_srs EPSG:%user_crs% reproj_shelters.geojson shelters.geojson

:: sanitary_facilities 
ogr2ogr -t_srs EPSG:%user_crs% reproj_sani.geojson sanitary_facilities.geojson

:: electricity 
ogr2ogr -t_srs EPSG:32632 reproj_elec.geojson electricity.geojson

:: trainstations 
ogr2ogr -t_srs EPSG:%user_crs% reproj_train.geojson trainstations.geojson

:: rasterize all layers
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_user_area.geojson rast_user_area.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_water_point.geojson rast_water_point.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_super.geojson rast_super.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_shelters.geojson rast_shelters.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_sani.geojson rast_sani.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_elec.geojson rast_elec.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_elec.geojson rast_trainstations.tif


:: user area
gdal_proximity -srcband 1 -distunits GEO -maxdist 500.0 -ot Float32 -of GTiff rast_user_area.tif proxim_user_area.tif
gdal_calc -A proxim_user_area.tif --outfile=reclass_proxim_user_area.tif --calc="100*(A<=100)+50*(A>100)*(A<=500)+10*(A>500)"

:: elec points
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_elec.tif proxim_elec.tif
gdal_calc -A proxim_elec.tif --outfile=reclass_proxim_elec.tif --calc="100*(A<=100)+50*(A>100)*(A<=250)+10*(A>250)"

:: sanitary facilities
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_sani.tif proxim_sani.tif
gdal_calc -A proxim_sani.tif --outfile=reclass_proxim_sani.tif --calc="100*(A<=100)+50*(A>100)*(A<=250)+10*(A>250)"

:: shelters
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_shelters.tif proxim_shelters.tif
gdal_calc -A proxim_shelters.tif --outfile=reclass_proxim_shelters.tif --calc="100*(A<=100)+50*(A>100)*(A<=250)+10*(A>250)"

::supermarkets
gdal_proximity -srcband 1 -distunits GEO -maxdist 1000.0 -ot Float32 -of GTiff rast_super.tif proxim_super.tif
gdal_calc -A proxim_super.tif --outfile=reclass_proxim_super.tif --calc="100*(A<=500)+50*(A>500)*(A<=1000)+10*(A>1000)"

:: train stations
gdal_proximity -srcband 1 -distunits GEO -maxdist 500.0 -ot Float32 -of GTiff rast_trainstations.tif proxim_trainstations.tif
gdal_calc -A proxim_trainstations.tif --outfile=reclass_proxim_trainstations.tif --calc="100*(A<=100)+50*(A>100)*(A<=500)+10*(A>500)"


:: water points
gdal_proximity -srcband 1 -distunits GEO -maxdist 250.0 -ot Float32 -of GTiff rast_water_point.tif proxim_water_point.tif
gdal_calc -A proxim_water_point.tif --outfile=reclass_proxim_water_point.tif --calc="100*(A<=100)+50*(A>100)*(A<=250)+10*(A>250)"


:: calculate values
gdal_calc -A reclass_proxim_user_area.tif -B reclass_proxim_elec.tif -C reclass_proxim_sani.tif -D reclass_proxim_shelters.tif -E reclass_proxim_super.tif -F reclass_proxim_trainstations.tif -G reclass_proxim_water_point.tif -- calc="A+B+C+D+E+F+G"