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


:: Herunterladen von Flächen größer als gewählte Input-Größe
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=((amenity=parking or highway=services or amenity=conference_center or leisure=stadium) and area:(%user_area%..))" ^
-o user_area.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Herunterladen von Trinkwasser-Stellen
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=amenity=drinking_water" ^
-o water_point.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Herunterladen von Anschlüssen an Stromverteiler
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=power=substation" ^
-o electricity.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Herunterladen von Sanitäranlagen (Toiletten, Duschen)
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=(amenity=toilets or amenity=shower)" ^
-o sanitary_facilities.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Herunterladen von Nahrungsmittelversorgung (Supermarkt)
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=shop=supermarket" ^
-o supermarkets.geojson ^
https://api.ohsome.org/v1/elements/geometry


:: Herunterladen von Unterkünften
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=(building=sports_hall or building=pavilion or leisure=dance or amenity=community_centre or amenity=exhibition_centre)" ^
-o shelters.geojson ^
https://api.ohsome.org/v1/elements/geometry

:: Herunterladen von Bahnhöfen
curl -X POST ^
--data-urlencode "bboxes=%user_bbox%" ^
--data-urlencode "time=%user_date%" ^
--data-urlencode "filter=railway=station" ^
-o trainstations.geojson ^
https://api.ohsome.org/v1/elements/geometry