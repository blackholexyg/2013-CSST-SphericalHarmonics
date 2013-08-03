%clc;
clear;close all;

global filepath;
global filename;

% Set file path and name
% filepath='~/Data/';
% filename='';

filepath='~/Data/Debug/';
filename='T9_3';

inpath = [filepath 'output/'];
infile = [filename '_debug'];
outpath = [filepath 'plot/'];
outfile = [filename '_plot'];

% load data
load([inpath infile]);

%% Plot Coefficients

% output filename
plottitle=filename;
plottitle(plottitle=='_')='-';
range=10;

h=figure;
plot(Cnm(2:end),'*');
t=title([ plottitle '-Cnm'],'FontSize',30);
axis([0 60 -range range])

print(h,'-dpng',[ outpath outfile '_Cnm' '.png'])
close(h)

h=figure;
plot(Snm,'*');
t=title([ plottitle '-Snm'],'FontSize',30);
axis([0 60 -range range])

print(h,'-dpng',[ outpath outfile '_Snm' '.png'])
close(h)
