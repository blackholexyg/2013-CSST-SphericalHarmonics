%clc;
clear;close all;

global num;
global filelist;
global filepath;

%% Plot Coefficients

filename=filelist{num}  %#ok<NOPTS>

load([filepath filename '_expand2']);

% output filename
outfile=filename;
outfile(outfile=='_')='-';
range=0.3;

h=figure;
plot(Cnm(2:end),'*');
t=title([ outfile ' Cnm'],'FontSize',30);
axis([0 60 -range range])

print(h,'-dpng',[ filepath outfile '_Cnm' '.png'])
close(h)

h=figure;
plot(Snm,'*');
t=title([ outfile ' Snm'],'FontSize',30);
axis([0 60 -range range])

print(h,'-dpng',[ filepath outfile '_Snm' '.png'])
close(h)


