%% %% MTEX SCRIPT FOR EBSD DATA PROCESSING%%
% 
% MTEX 5.2
% compiled by Michal Bukala
% version June 2023
%% Calculations for strain analysis %
% Calculate KAM2, M2M and GOS 
%
% Omphacite
KAM2_data_Cpx = KAM(ebsd('Omphacite'),'order',2,'threshold',segAngle)./degree; % Calculates KAM2
M2M_data_Cpx = ebsd('Omphacite').mis2mean.angle./degree; % Calculates Mis2Mean
GOS_data_Cpx = grainsSelected('Omphacite').GOS./degree; % Calculates GOS
%
%% Plotting maps of strain analysis 
% KAM2 map
col=ind2rgb(ebsd.bc,gray(255));
col=squeeze(col);
plot(ebsd,col)
hold on
plot(ebsd('Omphacite'),KAM2_data_Cpx)
caxis([1 10])
mtexColorMap LaboTeX
hold on
plot(grainsSelected_SG.boundary('Omphacite'),'linecolor',[1 0.2 0.2],'linewidth',0.2) % Plot (sub)grain boundaries of 2°
hold on
plot(grainsSelected.boundary('Omphacite'),'linecolor',[0 0 0],'linewidth',0.2) % Plot grain boundaries with normal angle (15°)
colorbar
%legend('hide')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveFigure(KAM2map)
%%
% M2M map
col=ind2rgb(ebsd.bc,gray(255));
col=squeeze(col);
plot(ebsd,col)
hold on
plot(ebsd('Omphacite'),M2M_data_Cpx) 
caxis([1 10])
mtexColorMap WhiteJet
hold on
plot(grainsSelected_SG.boundary('Omphacite'),'linecolor',[1 0.2 0.2],'linewidth',0.2) % Plot (sub)grain boundaries of 2°
hold on
plot(grainsSelected.boundary('Omphacite'),'linecolor',[0 0 0],'linewidth',0.2) % Plot grain boundaries with normal angle (15°)
%legend('hide')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveFigure(M2mMap)
%
%%
% GOS map
col=ind2rgb(ebsd.bc,gray(255));
col=squeeze(col);
plot(ebsd,col)
hold on
plot(grainsSelected('Omphacite'),grainsSelected('Omphacite').GOS./degree) 
caxis([1 10])
mtexColorMap LaboTeX
hold on
plot(grainsSelected.boundary,'linecolor',[0 0 0],'linewidth',0.2) % Plot grain boundaries with normal angle (15°)
colorbar
%legend('hide')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
hold off
saveFigure(GOSMap)
%
%% 
% Orientation map + grain boundaries with IPF colorbar for r = xvector
figure
oM_mono = ipfHSVKey(ebsd('Omphacite'))
oM_mono.inversePoleFigureDirection = xvector;
plot(ebsd,ebsd.bc,'figSize','large')
colormap gray
hold on
plot(ebsd('Omphacite'),oM_mono.orientation2color(ebsd('Omphacite').orientations),'figSize','large')
hold on
plot(grains('Omphacite').boundary,'linecolor',[0 0 0],'linewidth',0.2)
saveFigure('Omp_orientation_GrainBoundaries_ipfcolourbar_x.png')
%
figure
plot(oM_mono)
annotate([Miller(1,0,0,Omphacite_CS,'uvw'),...
          Miller(0,1,0,Omphacite_CS,'uvw'),...
          Miller(0,0,1,Omphacite_CS,'uvw')],...
         'antipodal','all','labeled','FontSize',25)
%
