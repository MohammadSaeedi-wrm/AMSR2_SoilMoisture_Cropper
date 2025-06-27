# AMSR2_SoilMoisture_Cropper

A MATLAB script to perform batch extraction of the AMSR2_SM variable from NetCDF files.
Users specify the cropping indices for latitude and longitude; the script reads each input file, subsets the data, permutes dimensions as needed, and writes the cropped soil-moisture slice (and its lat/lon coordinates) into individual output NetCDFs. A live console progress indicator shows filename and completion percentage.
