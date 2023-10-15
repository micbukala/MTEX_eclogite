%% %% MTEX SCRIPT FOR EBSD DATA PROCESSING%%
% 
% MTEX 5.2
% compiled by Michal Bukala
% version June 2023
%% PPlotting the pole figures
%
% rotation of EBSD data
ebsd_rot = rotate(ebsd,rotation('Euler',0*degree,0*degree,0*degree));
% reconstruction of grains in rotated EBSD data
[grains_rot,ebsd_rot.grainId,ebsd_rot.mis2mean] = calcGrains(ebsd_rot,'angle',segAngle);
grainsSelected_rot = grains_rot(grains_rot.grainSize > small_grains_option);
%
%% List of pole figures 
% Create list of pole figures with hkl & uvw 100,010,001
% Poles to planes can be specified by the option 'pole' or 'hkl' 
%
PF1Cpx_100 = Miller(1,0,0,Omphacite_CS,'uvw');
PF2Cpx_010 = Miller(0,1,0,Omphacite_CS,'uvw');
PF3Cpx_001 = Miller(0,0,1,Omphacite_CS,'uvw');
PFs_Cpx = {PF1Cpx_100,PF2Cpx_010,PF3Cpx_001}
%
% Calculate an ODF (whole dataset, rotated)
odf_rot_Cpx = calcODF(ebsd_rot('Omphacite').orientations,'halfwidth',8.5*degree);
% Calculate ODF & Jindex - OPPG
OnePPGrains_rot_Cpx = grainsSelected_rot('Omphacite').meanOrientation;
% Calculate an ODF - OPPG
odf_rot_Cpx_OnePPG = calcODF(OnePPGrains_rot_Cpx,'halfwidth',8.5*degree)
%
%% Pole figures
%
close all
%
figure
plotPDF(odf_rot_Cpx,PFs_Cpx,'antipodal','lower','minmax','on','resolution',2*degree,'contourf');
mtexColorMap white2black
mtexColorbar
saveFigure(CpxAllContoured)
%%
%close all
%
figure
plotPDF(odf_rot_Cpx_OnePPG,PFs_Cpx,'antipodal','lower','minmax','on','resolution',2*degree,'contourf');
mtexColorMap white2black
mtexColorbar
saveFigure(CpxOppgContoured)
