%% %% MTEX SCRIPT FOR EBSD DATA PROCESSING%%
% 
% MTEX 5.2
% compiled by Michal Bukala
% version June 2023
%% % IMPORT OF EBSD DATA %
%% Import Script for EBSD Data
%
% This script was created with the MTEX5.2 import wizard. 
% You should run the whoole script or parts of it in order to import your data. 
% There is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% exclude crystal symetry of phases that were not indexed in a sample

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('m-3m', [12 12 12], 'mineral', 'Almandine', 'color', [0.90 0.20 0.03]),...
  crystalSymmetry('-1', [8.2 13 14], [93.17,115.95,91.22]*degree, 'X||a*', 'Z||c', 'mineral', 'Anorthite', 'color', [0.40 0.40 0.40]),...
  crystalSymmetry('12/m1', [9.6 8.8 5.3], [90,106.8,90]*degree, 'X||a*', 'Y||b*', 'Z||c', 'mineral', 'Omphacite', 'color', [0.33 0.53 0.15]),...
  crystalSymmetry('-3m1', [4.9 4.9 5.5], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Quartz', 'color', [0.93 0.73 0.25]),...
  crystalSymmetry('4/mmm', [4.6 4.6 3], 'mineral', 'Rutile', 'color', [0.40 0.20 0.20]),...
  crystalSymmetry('mmm', [18 8.8 5.2], 'mineral', 'Enstatite', 'color', [1 1 1]),...
  crystalSymmetry('-3', [5.1 5.1 14], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Ilmenite', 'color', [0.92 0.69 0.92]),...
  crystalSymmetry('m-3m', [8.4 8.4 8.4], 'mineral', 'Magnetite', 'color', [0 0 0]),...
  crystalSymmetry('6/m', [9.5 9.5 6.9], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Apatite', 'color', [0.80 0.80 0.80]),...
  crystalSymmetry('12/m1', [6.6 8.7 7.4], [90,119.72,90]*degree, 'X||a*', 'Y||b*', 'Z||c', 'mineral', 'Titanite', 'color', [1.00 0.89 0.70]),...
  crystalSymmetry('12/m1', [9.9 18 5.3], [90,105.22,90]*degree, 'X||a*', 'Y||b*', 'Z||c', 'mineral', 'Pargasite', 'color', [0.19 0.81 0.98]),...
  crystalSymmetry('-3m1', [5 5 17], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Calcite', 'color', [0.97 0.84 0.76]),...
  crystalSymmetry('mmm', [16 5.6 10], 'mineral', 'Zoisite', 'color', [0.90 0.59 0.45]),...
  crystalSymmetry('12/m1', [8.8 5.6 10], [90,115.54,90]*degree, 'X||a*', 'Y||b*', 'Z||c', 'mineral', 'Clinozoisite', 'color', [0.90 0.59 0.45]),...
  crystalSymmetry('12/m1', [5.1 8.9 19], [90,94.51,90]*degree, 'X||a*', 'Y||b*', 'Z||c', 'mineral', 'Paragonite', 'color', [0.80 0.20 0.60]),...
  crystalSymmetry('-1', [7.1 7.9 5.6], [89.99,101.11,106.03]*degree, 'X||a*', 'Z||c', 'mineral', 'Kyanite', 'color', [0.14 0.57 0.57]),...
  crystalSymmetry('12/m1', [5.4 9.3 14], [90,96.28,90]*degree, 'X||a*', 'Y||b', 'Z||c', 'mineral', 'Clinochlore', 'color', [0.58 0.43 0.85])};

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = 'C:\'; %provide a directory to the .ctf file

% which files to be imported
fname = [pname '\[file_name].ctf']; %provide a .ctf file name

%% Import the Data

% create an EBSD variable containing the data
ebsd = EBSD.load(fname,CS,'interface','ctf',...
  'convertSpatial2EulerReferenceFrame');
%
%% Create output file
output_file = fopen('[file_name]_output.txt', 'w'); %provide a .ctf file name
fprintf(output_file,'Processed file : [file_name]_output_proc'); %provide a .ctf file name
%
%% Generate simple Crystal Symmetry variables for all phases
fprintf(' \n');
fprintf(' Crystal Symmetry (CS) : names of variables \n');
fprintf(' \n');
Phase_names = ebsd.mineralList;
for i=1:length(CS)
% indexed point for mineral
     N_Points = length(ebsd(Phase_names(i)));
% print only indexed phases 
    if((~strcmpi(Phase_names{i},'notIndexed')) && (N_Points > 0))
% retain first part of mineral name
      P_Name = strtok(char(Phase_names{i}),' ');
% make variables for CS with mineral names
      myvariable = strcat(P_Name,'_CS');
      datavalues = CS{i};
% print variable names for CS
      eval([sprintf(myvariable) ' = CS{i};'])
      fprintf(' %s %s \n','Variable name =',myvariable);
    end
end
disp(' ')
disp(' Use mineral_CS to defined your CS in m-file ')
disp(' ')
%