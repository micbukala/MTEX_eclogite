%% %% MTEX SCRIPT FOR EBSD DATA PROCESSING%%
% 
% MTEX 5.2
% compiled by Michal Bukala
% version June 2023
%
%% Number of calculated grains
% number of grains after removing small grains
number_of_grt_grains_selected = grainsSelected('Almandine').length
%number_of_omp_grains_selected = grainsSelected('Omphacite').length
%number_of_pg_grains_selected = grainsSelected('Pargasite').length
%number_of_par_grains_selected = grainsSelected('Paragonite').length
%number_of_qz_grains_selected = grainsSelected('Quartz').length
%number_of_an_grains_selected = grainsSelected('Anorthite').length
%number_of_rt_grains_selected = grainsSelected('Rutile').length
%number_of_ilm_grains_selected = grainsSelected('Ilmenite').length
%number_of_ap_grains_selected = grainsSelected('Apatite').length
%number_of_tnt_grains_selected = grainsSelected('Titanite').length
%number_of_calc_grains_selected = grainsSelected('Calcite').length
%number_of_zo_grains_selected = grainsSelected('Zoisite').length
%number_of_czo_grains_selected = grainsSelected('Clinozoisite').length
%number_of_ky_grains_selected = grainsSelected('Kyanite').length
%number_of_chl_grains_selected = grainsSelected('Clinochlore').length
%
% write to output file
fprintf(output_file,'\n\n');
fprintf(output_file,'Removed small grains option : %i \n',small_grains_option)
%fprintf(output_file,'Number of calculated grains (all phases) after removing small grains : %i \n',number_of_grains_selected)
%fprintf(output_file,'Number of calculated garnet grains after removing small grains : %i \n',number_of_grt_grains_selected)
%fprintf(output_file,'Number of calculated omphacite grains after removing small grains : %i \n',number_of_omp_grains_selected)
%fprintf(output_file,'Number of calculated pargasite after removing small grains : %i \n',number_of_pg_grains_selected)
%fprintf(output_file,'Number of calculated mica grains after removing small grains : %i \n',number_of_par_grains_selected)
%fprintf(output_file,'Number of calculated anorthite grains after removing small grains : %i \n',number_of_an_grains_selected)
%fprintf(output_file,'Number of calculated rutile grains after removing small grains : %i \n',number_of_rt_grains_selected)
%fprintf(output_file,'Number of calculated ilmenite grains after removing small grains : %i \n',number_of_ilm_grains_selected)
%fprintf(output_file,'Number of calculated apatite grains after removing small grains : %i \n',number_of_ap_grains_selected)
%fprintf(output_file,'Number of calculated titanite grains after removing small grains : %i \n',number_of_tnt_grains_selected)
%fprintf(output_file,'Number of calculated calcite grains after removing small grains : %i \n',number_of_calc_grains_selected)
%fprintf(output_file,'Number of calculated zoisite grains after removing small grains : %i \n',number_of_zo_grains_selected)
%fprintf(output_file,'Number of calculated clinozoisite grains after removing small grains : %i \n',number_of_czo_grains_selected)
%fprintf(output_file,'Number of calculated kyanite grains after removing small grains : %i \n',number_of_ky_grains_selected)
%fprintf(output_file,'Number of calculated clinochlore grains after removing small grains : %i \n',number_of_chl_grains_selected)
%
%% Histogram of grain size of a given phase
close all
histogram(grainsSelected('Omphacite').area,10)
xlabel('grain area')
ylabel('number of grains')
%
%% Plot Grains colored by aspect ratio (lenght/width)
% Omphacite
plot(grainsSelected('Omphacite'),grainsSelected('Omphacite').aspectRatio,'figSize','large')
colormap(hot)
caxis([1 3])
mtexColorbar
%% Plot grains coloured by shape factor (perimeter/equivalent perimeter)
% Omphacite
plot(grainsSelected('Omphacite'),grainsSelected('Omphacite').shapeFactor,'figSize','large')
hold on
caxis([1 4])
mtexColorbar
%% Plot grains coloured by area
% Omphacite
plot(grainsSelected('Omphacite'),grainsSelected('Omphacite').area,'figSize','large')
caxis([1 30000])
mtexColorbar
%
%% Shape parameters
ebsd_indexed = ebsd('indexed') % remove all not indexed pixels
%[grains, ebsd.grainId] = calcGrains(ebsd,'angle',12*degree) % reconstruct grains
grains_sm = smooth(grainsSelected,2) % smooth them
plot(ebsd_indexed('Omphacite'),ebsd_indexed('Omphacite').orientations) % plot the orientation data of the Omphacite
hold on
plot(grainsSelected.boundary,'linecolor',[0 0 0],'lineWidth',0.2) % plot the grain boundary on top of it
hold off
%
%% Fitted ellipses - Many shape parameters refers to ellipses fit to the grains
[omega,a,b] = grains_sm('Omphacite').fitEllipse
plot(grains_sm,'linecolor',[0 0 0],'linewidth',0.5)
plotEllipse(grains_sm('Omphacite').centroid,a,b,omega,'lineColor',[1 1 1],'linewidth',0.2)
%




