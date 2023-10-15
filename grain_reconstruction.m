%% %% MTEX SCRIPT FOR PROCESSING ECLOGITE EBSD DATA %%
% 
% MTEX 5.2
% compiled by Michal Bukala
% version June 2023
%% Grain reconstruction
%% Reconstruction of subgrains
% Choose a segmentation angle in the range of 12°-15°
ebsd_SG=ebsd;
segmentation_angle_SG = 2; % definition of an angle of subgrain boundary
segAngle_SG = segmentation_angle_SG*degree;
[grains_SG,ebsd_SG.grainId,ebsd_SG.mis2mean] = calcGrains(ebsd_SG,'angle',segAngle_SG);
number_of_calcGrains_SG = grains_SG.length
small_grains_option = 10;
grainsSelected_SG = grains_SG(grains_SG.grainSize > small_grains_option);
%
%% Reconstruction of grains  
% Choose a segmentation angle in the range of 12°-15°
segmentation_angle = 12; 
segAngle = segmentation_angle*degree;
[grains,ebsd.grainId,ebsd.mis2mean] = calcGrains(ebsd,'angle',segAngle);
grainsSelected = grains(grains.grainSize > small_grains_option);
%
%% Phase map with subgrain and grain boudaries
plot(ebsd)
hold on
plot(grainsSelected_SG.boundary,'linecolor',[1 0.2 0.2],'linewidth',0.2) % Plot (sub)grain boundaries of 2°
hold on
plot(grainsSelected.boundary,'linecolor',[0 0 0],'linewidth',0.2) % Plot grain boundaries with normal angle (12°)
%legend('hide')
hgt = findall(gca,'type','hgtransform')
set(hgt,'visible','off')
%
saveFigure(phasemap)
%
%% Plot check MAD map (mean angle deviation)
% low values (white) are expected, lower MAD = better
figure
plot(ebsd('indexed'),ebsd('indexed').mad,'figSize','large')
mtexColorMap white2black
mtexColorbar
saveFigure('map_Mean_Angular_Deviation_initial.png')
% bc gray map 8-bit Band Contrast (bc) Map - good indicator of grain boundaries
%% Plot check BC map (band contrast)
% low values (black) indicate a small contrast, higher BC = better
figure
plot(ebsd,ebsd.bc,'figSize','large')
colormap gray
mtexColorbar
saveFigure('map_Band_Contrast_initial.png')