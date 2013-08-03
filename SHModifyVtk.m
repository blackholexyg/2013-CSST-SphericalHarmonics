%clc;
clear;

global filepath;
global filename;

% Set file path and name
% filepath='~/Data/';
% filename='';

inpath = [filepath 'output/'];
infile = [filename '_original'];
outpath = [filepath 'output/'];
outfile = [filename '_new_r'];

% load data
load([inpath infile]);

%% Change R

%     r(i)=cos(test_m*lambda(i) ) .*SHPnm(test_n,test_m,theta(i) );

for i=1:NUM_NODES
    S1=1 * cos( 0 *lambda(i) ) .*SHPnm( 0 , 0 ,theta(i) );
    S2=2 * cos( 0 *lambda(i) ) .*SHPnm( 1 , 0 ,theta(i) );
    S3=3 * cos( 1 *lambda(i) ) .*SHPnm( 1 , 1 ,theta(i) );
    S4=4 * cos( 0 *lambda(i) ) .*SHPnm( 2 , 0 ,theta(i) );
    S5=5 * cos( 1 *lambda(i) ) .*SHPnm( 2 , 1 ,theta(i) );
    S6=6 * cos( 2 *lambda(i) ) .*SHPnm( 2 , 2 ,theta(i) );
    S7=7 * cos( 0 *lambda(i) ) .*SHPnm( 3 , 0 ,theta(i) );
    S8=8 * cos( 1 *lambda(i) ) .*SHPnm( 3 , 1 ,theta(i) );
    S9=9 * cos( 3 *lambda(i) ) .*SHPnm( 3 , 2 ,theta(i) );
    r(i)=S1+S2+S3+S4+S5+S6+S7+S8+S9;
end

%% Rotate Coordinates

% load([filepath filename '_coordinates']);
% 
% oldx=x;
% oldy=y;
% oldz=z;
% 
% rotate_theta_x=pi*5/6;
% y=cos(rotate_theta_x).*oldy-sin(rotate_theta_x).*oldz;
% z=sin(rotate_theta_x).*oldy+cos(rotate_theta_x).*oldz;
% 
% oldx=x;
% oldy=y;
% oldz=z;
% 
% rotate_theta_y=pi/7;
% x=cos(rotate_theta_y).*oldx+sin(rotate_theta_y).*oldz;
% z=-sin(rotate_theta_y).*oldx+cos(rotate_theta_y).*oldz;
% 
% oldx=x;
% oldy=y;
% oldz=z;
% 
% rotate_theta_z=0;
% x=cos(rotate_theta_z).*oldx-sin(rotate_theta_z).*oldy;
% y=sin(rotate_theta_z).*oldx+cos(rotate_theta_z).*oldy;
% 
% r=zeros(NUM_NODES,1);
% theta=zeros(NUM_NODES,1);
% lambda=zeros(NUM_NODES,1);
% 
% for i=1:NUM_NODES
%     r(i)=sqrt(x(i)^2+y(i)^2+z(i)^2);
%     theta(i)=atan(sqrt(x(i)^2+y(i)^2)/z(i));
%     if theta(i)<0
%         theta(i)=pi+theta(i);
%     end
%     lambda(i)=atan2(y(i),x(i));
%     if lambda(i)<0
%         lambda(i)=2*pi+lambda(i);
%     end
% end


%% save files
savefile=[ outpath outfile];
save(savefile,'NUM_NODES','x','y','z','r','theta','lambda','NUM_TRI','TRI');
