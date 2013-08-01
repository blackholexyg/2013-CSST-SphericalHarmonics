clc,clear;

global num;
global filepath;
global filelist;

filepath='~/Data/VirusTest/';

% get filelist
fid=fopen([filepath 'filelist.txt']);

i=1;
tline = fgetl(fid);
while ischar(tline)
    filelist{i}=tline;
    tline = fgetl(fid);
    i=i+1;
end

fclose(fid);

for num=1:length(filelist)
    % Do loop operations
    
    % Preprocessing:
    % SHReadVtk;
    
    % Calculating:
    % SHExpand;
    
    % Posprocessing:
    % SHPlot;
    
    % Other:
    % SHRotate;
    SHLoop;
end
