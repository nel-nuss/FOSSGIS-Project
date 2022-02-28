:: Script to reproject the downloaded vector layers using ogr2ogr and rasterizing them with gdal_rasterize (GDAL)

:: user_area 
ogr2ogr -t_srs EPSG:32632 reproj_user_area.geojson user_area.geojson

:: water_point 
ogr2ogr -t_srs EPSG:32632 reproj_water_point.geojson water_point.geojson

:: supermarkets 
ogr2ogr -t_srs EPSG:32632 reproj_super.geojson supermarkets.geojson

:: shelters
ogr2ogr -t_srs EPSG:32632 reproj_shelters.geojson shelters.geojson

:: sanitary_facilities 
ogr2ogr -t_srs EPSG:32632 reproj_sani.geojson sanitary_facilities.geojson

:: electricity 
ogr2ogr -t_srs EPSG:32632 reproj_elec.geojson electricity.geojson

:: trainstations 
ogr2ogr -t_srs EPSG:32632 reproj_train.geojson trainstations.geojson

:: rasterize all layers
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_user_area.geojson rast_user_area.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_water_point.geojson rast_water_point.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_super.geojson rast_super.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_shelters.geojson rast_shelters.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_sani.geojson rast_sani.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_elec.geojson rast_elec.tif
gdal_rasterize -burn 1.0 -tr 10.0 10.0 -ot Float32 -of GTiff reproj_elec.geojson rast_trainstations.tif
