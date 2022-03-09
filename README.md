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

In this analysis, we choose adequate staging areas based on a few parameters:

- A general area in which we run the analysis, delimited by a *bounding box* (user input)
- *Large paved areas* (user input) that meet a certain size requirements, for setting up tents and to park vehicles (recommended: at least 1500-2000 m²)
- Areas must have *good accessibility* via roads and surrounding features must also be close by.
- Proximity to *Food supply locations* e.g. supermarkets
- *train stations* to facilitate arrival of helpers
- *Shelters* where helpers could sleep e.g. gyms, community centres since setting tents up costs time
- Optional: access  to *sanitary facilities, drinking water, electricity, sewage* since setting these up is possible but costs time and resources



#### **Requirements:** 

1. Make sure you are on Windows or find a way to run .bat files.
2. Make sure you have an active internet connection.
3. Make sure you have the following software installed:
QGIS (recommended: current LTR version)
We recommend installing from [OSGeo4W](https://trac.osgeo.org/osgeo4w/) since it comes with the OSGeo4W shell that allows you to run gdal commands that are needed for the analysis. Follow the installation instructions on the website.
4. Create a folder in a location of your choice on your device. Make sure that the name does not contain invalid characters or spaces. 
5. Download all scripts into this folder. It will later contain all intermediate and result files.



#### Data download: 

In this script you will download the necessary data for the parameters/amenities via the ohsome API.

Steps: 

1. Open the OSGeo4W shell.
2. Type cd followed by the path that leads to the folder you created (see example below). Press Enter to confirm. This will set the general path to that folder so you only have to type in file names, without copying the entire path every time.
```
cd C:\Users\Example_User\Example_Folder
```
3. Type in data_download.bat and hit Enter.
4. Add your user variables when prompted, confirming with Enter.
5. Optional but recommended: Open the downloaded layers in QGIS. If they can be opened, proceed. If you get an "Invalid layer" error, refer to the common error section or open an issue.


User input variables: 

- %user_bbox%: you can copy a bounding box from [here](http://boundingbox.info/). Make sure to copy from the WSG84 - EPSG:4326 entry.
Example format: 8.65242004394531,49.37325290762636,8.716964721679688,49.42910795585707

- %user_date%: You can only use a day that dates back more than ten days since OSM needs time to update newly mapped features. It needs to be in YYYY-MM-DD format.
Example format: 2022-12-31

- %user_area%: Enter the required area size in m². We recommend a size of at least 1500-2000 m². 


You will obtain the following layers:

- water_point.geojson
- supermarkets.geojson
- user_area.geojson
- shelters.geojson
- sanitary_facilities.geojson
- electricity.geojson
- trainstations.geojson 

Common errors:
1. Sometimes, the API is not available. Retry later.
2. Sometimes, entering the user input variables goes wrong and an invalid layer is returned. You can check layer validity by loading them into QGIS, if invalid, QGIS will show a red error message. In that case, open the invalid layer.geojson in the Editor program and try to determine the error from the file contents.


#### Reprojection, Rasterization, Proximity Raster Generation: 
The script multicriteria_analysis_calc.bat contains all the needed reprojection, rasterization, proximity raster generation reclassification and calculation steps. It is executed the same way as data_download.bat **However, it is currently BROKEN at the Proximity Raster Generation step. Therefore, the steps have been split up.**

The script reproject_ratserize.bat will reproject your downloaded layers into a new Coordinate reference System and rasterize them. 
The commands in proximity_and_calc.bat are still executable, just not the whole script for an unknown reason. You can circumvent this by executing each line of code individually.

1. Make sure you are still in the correct folder in the OSGeo4W shell.
2. Type reproject_rasterize.bat to execute the next script.
3. When prompted, enter the EPSG code of the CRS you need your layers in. Enter only the numbers.
4. Then open the script proximity_and_calc.bat in the Editor app and copy out the lines of code and execute them individually. Lines that start with :: are comments and need not be copied.

User input variable:
- %user_crs%: You need to enter the EPSG code of a CRS that fits the requirements for the calculation. It needs to be in metric units [m] and has to cover the area you are running the calculation on. We recommend UTM since they are very accurate for the corresponding area and in m. The website [epsg.io](https://epsg.io/) can help you find the EPSG code you need. Suggestion: In the search function, type utm and the country you are using data from, then pick the suggested CRS.

Example: For Southwestern Germany, choose UTM Zone 32N (EPSG: 32632). Simply enter 32632 when prompted and your layers will be reprojected into this CRS.

You will obtain intermediate files with the prefix reproj_ and raster_ as well as proxim_. 






------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Customisation options (ADVANCED):
Bounding box and area size are already customisable. If you want to customize the downloaded features or proximities, you can do so by opening the .bat files in the Editor app.
- Customising downloaded features: Open data_download.bat in the Editor app. You can add completely new features to be downloaded (make sure to include them in the subsequent steps, we recommend following the naming pattern for outputs and simply copying and altering the pre-existing code). You can also alter the features we are extracting. For the user areas for example, we extract parking areas, conference centers and stadiums (because they have large parking areas associated). If you would like to include other features that have large open areas associated, for example aerodromes, simply find the corresponding tag in OSM and add it to the code. Refer to the [ohsome API documentation](https://docs.ohsome.org/ohsome-api/v1/) for more information on how the code works.
- Customising accessibility/ proximity rasters: If you want to alter the distances between features, open proximity_and_calc.bat and change the distances listed in the gdal_proximity commands. Refer to the [GDAL documentation](https://gdal.org/programs/gdal_proximity.html) for more information on how this code works.
