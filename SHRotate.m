%clc;
clear;

global num;
global filelist;
global filepath;

%% Rotate
% calculate the coefficients for Cnm and Snm

filename=filelist{num}  %#ok<NOPTS>

load([filepath filename '_coordinates']);

oldx=x;
oldy=y;
oldz=z;

rotate_theta_x=pi*5/6;
y=cos(rotate_theta_x).*oldy-sin(rotate_theta_x).*oldz;
z=sin(rotate_theta_x).*oldy+cos(rotate_theta_x).*oldz;

oldx=x;
oldy=y;
oldz=z;

rotate_theta_y=pi/7;
x=cos(rotate_theta_y).*oldx+sin(rotate_theta_y).*oldz;
z=-sin(rotate_theta_y).*oldx+cos(rotate_theta_y).*oldz;

oldx=x;
oldy=y;
oldz=z;

rotate_theta_z=0;
x=cos(rotate_theta_z).*oldx-sin(rotate_theta_z).*oldy;
y=sin(rotate_theta_z).*oldx+cos(rotate_theta_z).*oldy;

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


% save files
savefile=[ filepath filename '_rotated_x_150_y_25' '.mat'];
save(savefile,'NUM_NODES','x','y','z','r','theta','lambda','NUM_TRI','TRI');
