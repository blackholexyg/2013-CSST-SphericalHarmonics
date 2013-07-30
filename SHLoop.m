%clc;
clear;close all;

global num;
global filelist;
global filepath;


%%

filename=filelist{num}  %#ok<NOPTS>
postfix='_rotated';

load([filepath filename postfix]);

[Cnm,Snm]=SHExpand(x,y,z,r,theta,lambda,NUM_TRI,TRI,10);

savefile=[ filepath filename '_expand2' '.mat'];
save(savefile,'Cnm','Snm');


%% Plot Coefficients

% filename=filelist{num}  %#ok<NOPTS>
% 
% 
% % output filename
% outfile=filename;
% outfile(outfile=='_')='-';
% range=0.3;
% 
% h=figure;
% hold on;
% 
% load([filepath filename '_expand']);
% plot(Cnm(2:end),'bx');
% load([filepath filename '_expand2']);
% plot(Cnm(2:end),'ro');
% 
% t=title([ outfile ' Cnm'],'FontSize',30);
% axis([0 60 -range range])
% 
% print(h,'-dpng',[ filepath outfile '_Cnm' '.png'])
% close(h)
% 
% h=figure;
% hold on;
% 
% load([filepath filename '_expand']);
% plot(Snm,'bx');
% load([filepath filename '_expand2']);
% plot(Snm,'ro');
% 
% t=title([ outfile ' Snm'],'FontSize',30);
% axis([0 60 -range range])
% 
% print(h,'-dpng',[ filepath outfile '_Snm' '.png'])
% close(h)


