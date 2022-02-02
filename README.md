## Optimizing the identification of suitable staging areas for disaster relief

######                                     Nel Nußberger, Anne-Liese Schömer 



The aim of this project is to identify suitable staging areas for disaster relief and to create a GIS tool to facilitate and accelerate the identification process of suitable sites. 

We will start with a site selection analysis and later on we will try to do a weighted site selection. 

#### **Quick reminder:** 

| SIMPLE SITE SELECTION                                        | WEIGHTED SITE ANALYSIS                            |
| :----------------------------------------------------------- | :------------------------------------------------ |
| raster and vector data                                       | only raster data                                  |
| easier and faster                                            | requires more steps and calculation               |
| vector data: perfect matches                                 | offers ideal sites and ranking of next best sites |
| raster data: ranking by how many criteria are met is possible | flexibility                                       |



#### **Parameters/amenities:** 

For this project you will need: 

- A *bounding box* (user input)
- *Large paved areas* (user input) for e.g. to set up tents and to park vehicles (1500-2000 m²)
- *Good accessibility* close to major roads (buffer), isoschrone analysis 
- Proximity to *Food supply locations* e.g. supermarkets, restaurants 
- *train stations*
- *Shelters* where people could sleep for e.g. gyms, community center
- Optional: access  to s*anitary facilities, drinking water, electricity, sewage* 



#### **Preparation:** 

For our project we will mostly work with QGIS 

1. *Software requirements:* QGIS (version: no special version needed)
2. *How to install:* you already have QGIS installed 
3. *Download* the data_download.bat



#### Script: 

In this script you will download the necessary data for the parameters/amenities. You can donwload the data with the ohsome API. The data_download.bat contains our script. You have to add the following user input variables to your skript.  

How to run the script: 

1. Execute the data_download.bat in your command-line
2. Add your user variables 



User input variables: 

- %user_bbox%: you can copie a bounding from http://boundingbox.info/ (we used the area Mannheim/Heidelberg)

- %user_date%: you can only use a day that dates back more than ten days 

- %user_area%: we need space with a required size of 1500 m² 

  

Your outcome will be:

- water_point.geojson
- supermarkets.geojson
- user_area.geojson
- shelters.geojson
- sanitary_facilities.geojson
- electricity.geojson
- trainstations.geojson 





