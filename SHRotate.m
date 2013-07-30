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

rotate_theta_x=pi/6;
y=cos(rotate_theta_x).*y-sin(rotate_theta_x).*z;
z=sin(rotate_theta_x).*y+cos(rotate_theta_x).*z;

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
savefile=[ filepath filename '_rotated' '.mat'];
save(savefile,'NUM_NODES','x','y','z','r','theta','lambda','NUM_TRI','TRI');
