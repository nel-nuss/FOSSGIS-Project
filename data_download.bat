:: Script for downloading OSM features with ohsome API (DOI 10.5281/zenodo.4146990).
:: See https://docs.ohsome.org/ohsome-api/v1/ for the documentation. 

:: Author: Nel Nußberger
:: Last edited: 30.03.2022

@echo OFF

echo Enter Bounding Box coordinates : 
set /p user_bbox=
echo The Bounding Box is %user_bbox%

echo Enter date (Format: 2022-12-31; must choose a date that dates back at least 10 days) : 
set /p user_date=
echo The Date is %user_date%

echo Enter required minimum size of the staging area (in m²) : 
set /p user_area=
echo The area size is %user_area% m²


:: Download areas larger than chosen area size
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=((amenity=parking or highway=services or amenity=conference_center or leisure=stadium) and area:(%user_area%..))" ^
-o user_area.geojson ^
https://api.ohsome.org/v1/elements/geometry

:: Download major roads
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=(highway=motorway or highway=primary or highway=secondary)" ^
-o roads.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Download points with access to drinking water
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=amenity=drinking_water" ^
-o water_point.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Download access points to power substations
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=power=substation" ^
-o electricity.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Download sanitary facilities (toilets, showers)
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=(amenity=toilets or amenity=shower)" ^
-o sanitary_facilities.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Download supermarkets
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=shop=supermarket" ^
-o supermarkets.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Download shelters
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=(building=sports_hall or building=pavilion or leisure=dance or amenity=community_center or amenity=exhibition_center)" ^
-o shelters.geojson ^
https://api.ohsome.org/v1/elements/geometry

:: Download trainstations
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=railway=station" ^
-o trainstations.geojson ^
https://api.ohsome.org/v1/elements/geometry