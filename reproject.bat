:: Script to reproject the downloaded vector layers using ogr2ogr (GDAL)

:: user_area 
ogr2ogr -t_srs EPSG:32632 reproject.geojson user_area.geojson

:: water_point 
ogr2ogr -t_srs EPSG:32632 reproj_water_point.geojson water_point.geojson

:: supermarkets 
ogr2ogr -t_srs EPSG:32632 reproj_super.geojson supermarkets.geojson

:: shelters
shelters ogr2ogr -t_srs EPSG:32632 reproj_shelters.geojson shelters.geojson

:: sanitary_facilities 
ogr2ogr -t_srs EPSG:32632 reproj_sani.geojson sanitary_facilities.geojson

:: electricity 
ogr2ogr -t_srs EPSG:32632 reproj_elec.geojson electricity.geojson

:: trainstations 
ogr2ogr -t_srs EPSG:32632 reproj_train.geojson trainstations.geojson