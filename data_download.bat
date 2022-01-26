@echo OFF

echo Eckpunkte der Bounding Box eingeben : 
set /p user_bbox=
echo Die ausgewaehlte Bounding Box ist %user_bbox%

echo Daten-Zeitstempel eingeben (Format: 2022-12-31; ca. 10 Tage zurueckliegendes Datum empfohlen) : 
set /p user_date=
echo Der ausgewaehlte Zeitstempel ist %user_date%

echo Groesse des Bereitstellungsraums (in Quadratmeter) eingeben : 
set /p user_area=
echo Die ausgewaehlte Groesse ist %user_area%


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