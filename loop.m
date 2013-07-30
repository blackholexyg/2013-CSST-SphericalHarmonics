clc,clear;

global num;
global filepath;
global filelist;

filepath='~/Data/VirusTest/';
filelist={'T9_3','T16_3','T25_3','T36_3'};

for num=1:length(filelist)
    % Do loop operations
    
    % Preprocessing:
    % SHReadVtk;
    
    % Calculating:
    % SHExpand;
    
    % Posprocessing:
    SHPlot;
end
