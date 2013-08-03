%clc;
clear;

global filepath;
global filename;

% Set file path and name
% filepath='~/Data/';
% filename='';

inpath = filepath;
infile = [filename '.vtk'];
outpath = [filepath 'output/'];
outfile = [filename '_original'];

%% Read Coordinates from VTK files


% open file
fid=fopen([inpath infile],'r');

% read first 4 lines
info_version=fgetl(fid);
info_format=fgetl(fid);
info_encoding=fgetl(fid);
info_title=fgetl(fid);

% Nodes
C=textscan(fid,'%s%d%s',1);
NUM_NODES=C{2};

C=textscan(fid,'%f%f%f',NUM_NODES);
x=C{1};
y=C{2};
z=C{3};

% Triangulars
C=textscan(fid,'%s%d%s',1);
NUM_TRI=C{2};

C=textscan(fid,'%d%d%d%d',NUM_TRI);
TRI=[C{2} C{3} C{4}];

fclose(fid);

% from cartesian coordinates to spherical coordinates
% r2=sqrt(x.*x+y.*y+z.*z);
% fuck this [theta,lambda,r]=cart2sph(x,y,z);

r=zeros(NUM_NODES,1);
theta=zeros(NUM_NODES,1);
lambda=zeros(NUM_NODES,1);

for i=1:NUM_NODES
    r(i)=sqrt(x(i)^2+y(i)^2+z(i)^2);
    theta(i)=atan(sqrt(x(i)^2+y(i)^2)/z(i));
    if theta(i)<0
        theta(i)=pi+theta(i);
    end
    lambda(i)=atan2(y(i),x(i));
    if lambda(i)<0
        lambda(i)=2*pi+lambda(i);
    end
end


%% save files
savefile=[ outpath outfile];
save(savefile,'NUM_NODES','x','y','z','r','theta','lambda','NUM_TRI','TRI');
