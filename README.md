## Optimizing the identification of suitable staging areas for disaster relief

######                                     Nel Nu√überger, Anne-Liese Sch√∂mer 



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
- *Large paved areas* (user input) for e.g. to set up tents and to park vehicles (1500-2000 m¬≤)
- *Good accessibility* close to major roads (buffer), isoschrone analysis 
- Proximity to *Food supply locations* e.g. supermarkets, restaurants 
- *train stations*
- *Shelters* where people could sleep for e.g. gyms, community center
- Optional: access  to s*anitary facilities, drinking water, electricity, sewage* 



#### **Requirements:** 

1. Make sure you are on Windows or find a way to run .bat files.
2. Make sure you have an active internet connection.
3. Make sure you have the following software installed:
QGIS (recommended: current LTR version)
We recommend installing from [OSGeo4W](https://trac.osgeo.org/osgeo4w/) since it comes with the OSGeo4W shell that allows you to run gdal commands that are needed for the analysis. Follow the installation instructions on the website.
4. Create a folder in a location of your choice on your device. Make sure that the name does not contain invalid characters or spaces. 
5. Download all scripts into this folder. It will later contain intermediate files and output files.



#### Data download: 

In this script you will download the necessary data for the parameters/amenities cvia the ohsome API.

Steps: 

1. Open the OSGeo4W shell.
2. Type cd followed by the path that leads to the folder you created.
3. Type in data_download.bat and hit Enter.
4. Add your user variables when prompted, confirming with Enter.


User input variables: 

- %user_bbox%: you can copy a bounding from [here] (http://boundingbox.info/). Make sure to copy from the WSG84 - EPSG:4326 entry.
Example format: 8.65242004394531,49.37325290762636,8.716964721679688,49.42910795585707

- %user_date%: You can only use a day that dates back more than ten days since OSM needs time to update newly mapped features. It needs to be in YYYY-MM-DD format.
Example format: 2022-12-31

- %user_area%: Enter the required area size in m≤. We recommend a size of at least 1500-2000 m≤. 


You will obtain the following layers:

- water_point.geojson
- supermarkets.geojson
- user_area.geojson
- shelters.geojson
- sanitary_facilities.geojson
- electricity.geojson
- trainstations.geojson 

Common errors:
Sometimes, the API is not available. Retry later.
Sometimes, entering the user input variables goes wrong and an invalid layer is returned. You can check layer validity by loading them into QGIS, if invalid, QGIS will show a red error message. In that case, open the invalid layer.geojson in the Editor program and try to determine the error from the files contents.


#### Reprojection, Rasterization, Proximity Raster Generation: 
This script will reproject your downloaded layers into a new Coordinate reference System, rasterize them and generate proximity rasters.

1. Make sure you are still in the correct folder in the OSGeo4W shell.
2. Type reproject_rasterize.bat to execucte the next script.

You will obtain intermediate files with the prefix reproj_ and raster_ as well as proxim_


