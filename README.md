## Optimizing the identification of suitable staging areas for disaster relief with GIS-based weighted multicriteria analysis

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
6. If you want to run the tool multiple times, create new folders every time and copy in the scripts.



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

The script reproject_rasterize.bat will reproject your downloaded layers into a new Coordinate reference System and rasterize them. 
The commands in proximity_and_calc.bat are still executable, just not the whole script for an unknown reason. You can circumvent this by executing each line of code individually.

1. Make sure you are still in the correct folder in the OSGeo4W shell.
2. Type reproject_rasterize.bat to execute the next script.
3. When prompted, enter the EPSG code of the CRS you need your layers in. Enter only the numbers. See notes below for more information.
4. Next, you will be prompted to enter the raster extent. Due to an error we are currently unable to fix, you need to manually find out and enter the specific extent for your bounding box. This is not an ideal solution, just a temporary workaround.
  1. Open the layer reproj_user_area in QGIS and double click it.
  
  2. Under "Information from provider" you fill find the extent of the layer, in the format xmin,ymin : xmax,ymax:
  Example: 474780.0649738621432334,5469451.3672149349004030 : 478149.9342137648491189,5474561.8126761987805367
  
  3. In order to enter the extent correctly, it needs to be in the correct format xmin ymin xmax ymax. 
  The 4 values must be separated by empty spaces instead of commas and colons.
  Example: 474780.065 5469451.3672 478149.9342 5474561.8127
  
  4. Paste in the extent and hit enter to execute.
  
  5. Double check the generated rasters.
5. Then open the script proximity_and_calc.bat in the Editor app and copy out the lines of code and execute them individually. Lines that start with :: are comments and need not be copied.

User input variable:
- %user_crs%: You need to enter the EPSG code of a CRS that fits the requirements for the calculation. It needs to be in metric units [m] and has to cover the area you are running the calculation on. We recommend UTM since they are very accurate for the corresponding area and in m. The website [epsg.io](https://epsg.io/) can help you find the EPSG code you need. Suggestion: In the search function, type utm and the country you are using data from, then pick the suggested CRS.

    Example: For Southwestern Germany, choose UTM Zone 32N (EPSG: 32632). Simply enter 32632 when prompted and your layers will be reprojected into this CRS.
  
- %rasterizing_extent%: You need to enter a raster extent in order to generate rasters of equal extent to be able to calculate the operations in proximity_and_calc.bat

You will obtain intermediate files with the prefix reproj_ and raster_ as well as proxim_ and reclass_. 



#### Visualising the results
1. Open QGIS and load the following layers:
- proxim_final_calc.tif (The final overlay of all rasters)
- rastermap150.tif (The raster overlay, but suitability values below 150 are classified as "unsuitable")
- rastermap175.tif (The raster overlay, but suitability values below 175 are classified as "unsuitable")
- rastermap200.tif (The raster overlay, but suitability values below 200 are classified as "unsuitable")
- reproj_user_area.geojson
2. Navigate to Web --> QuickMapServices --> OSM --> OSM Standard. (See below if this is not available)
3. Double click the rastermap-layers and navigate to Transparency and set Global Opacity to 75%
4. Now navigate to Symbology for each raster and set Render type to Singleband pseudocolor.
- Navigate to All Color ramps and choose the "RdYlGn" colour ramp.
5. Depending on the colour, double click the layer reproj_user_area and navigate to Symbology
- Pick a colour that is easily distinguishable from the raster layer
6. Evaluating the results:
- The greener the surrounding area of one of the potential staging areas, the more criteria are met. 
- There are some green areas where multiple criteria are met but no potential staging area is close, disregard these.
- Potential staging areas surrounded by red are unsuitable and should be disregarded.
- Use the underlying OSM map to identify addresses and also disregard any potential areas that can not be used in disaster relief, e.g. hospital parking spaces.

Depending on your provided area size and bounding box, you might obtain way too many or way too little potential areas to meaningfully consider as potential staging areas. Therefore, we provided three calculations that cut off suitability at certain ranks (150, 175, 200). Choose the map that is best suited to your needs. If none of the three options produce a useful result, open proximity_and_calc.bat and change the cutoff value provided in the last line of code.
Within the code, the flag ```--calc="(A>=200)*A"``` is responsible for setting and calculating the cut-off value. Simply change the number and see what kind of result you get with different numbers! When doing this, adjust the output name at ```--outfile=rastermapXXX.tif``` to reflect the cut-off value that was used.

(In case of red-green color vision deficiency, choose a color ramp that ranges from white to black or similar)


QuickMapServices: If this Plugin is not already pre-installed, navigate to Plugins --> Manage and install Plugins and use the search function to find and install it.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Customisation options (ADVANCED):
Bounding box and area size are already customisable. If you want to customize the downloaded features or proximities, you can do so by opening the .bat files in the Editor app.
- Customising downloaded features: Open data_download.bat in the Editor app. You can add completely new features to be downloaded (make sure to include them in the subsequent steps, we recommend following the naming pattern for outputs and simply copying and altering the pre-existing code). You can also alter the features we are extracting. For the user areas for example, we extract parking areas, conference centers and stadiums (because they have large parking areas associated). If you would like to include other features that have large open areas associated, for example aerodromes, simply find the corresponding tag in OSM and add it to the code. Refer to the [ohsome API documentation](https://docs.ohsome.org/ohsome-api/v1/) for more information on how the code works.
- Customising accessibility/ proximity rasters: If you want to alter the distances between features, open proximity_and_calc.bat and change the distances listed in the gdal_proximity commands. Refer to the [GDAL documentation](https://gdal.org/programs/gdal_proximity.html) for more information on how this code works.
