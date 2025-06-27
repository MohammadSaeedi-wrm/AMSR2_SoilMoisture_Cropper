clc; clear; close all;
AMSR2_Base_Folder = 'E:\Saeedi-Model\FinalModel\Global\AMSR2';
AMSR2_Crop_Folder = 'E:\Saeedi-Model\FinalModel\Global\AMSR2_2';
Lat_Cut = [192 193];
Lon_Cut = [21 22];
NC_AMSR2 = dir(fullfile(AMSR2_Base_Folder, '*.nc')); N_AMSR2 = numel(NC_AMSR2);
for i = 1:N_AMSR2
    Name_AMSR2 = NC_AMSR2(i).name;
    Input_Direction = fullfile(AMSR2_Base_Folder, Name_AMSR2);
    Output_Direction = fullfile(AMSR2_Crop_Folder, Name_AMSR2);
    Data_Crop_AMSR2 = ncread(Input_Direction, 'AMSR2_SM', [Lon_Cut(1), Lat_Cut(1)], [2, 2]);
    Soil_Moisture_Crop = permute(Data_Crop_AMSR2, [2 1]);
    Lat_All = ncread(Input_Direction, 'lat');
    Lon_All = ncread(Input_Direction, 'lon');
    Lat_Crop = Lat_All(Lat_Cut);
    Lon_Crop = Lon_All(Lon_Cut);
    nccreate(Output_Direction, 'AMSR2_SM', 'Dimensions', {'lat', 2, 'lon', 2});
    ncwrite(Output_Direction, 'AMSR2_SM', Soil_Moisture_Crop);
    nccreate(Output_Direction, 'lat', 'Dimensions', {'lat', 2});
    ncwrite(Output_Direction, 'lat', Lat_Crop);
    nccreate(Output_Direction, 'lon', 'Dimensions', {'lon', 2});
    ncwrite(Output_Direction, 'lon', Lon_Crop);
    percent = (i / N_AMSR2) * 100;
    msg = sprintf('➡️  Saved: %-30s  %6.2f%%', Name_AMSR2, percent);
    if i > 1; fprintf(repmat('\b', 1, numel(prev_msg))); end
    fprintf('%s', msg); prev_msg = msg;
end
fprintf('\n✔️  AMSR2 Crop Complete.\n');