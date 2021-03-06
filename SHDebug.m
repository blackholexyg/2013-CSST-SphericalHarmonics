clc;
clear;

global filepath;
global filename;

% Set file path and name

filepath='~/Data/Debug/';
filename='T9_3';

%% Temp Activity
% 
% SHReadVtk;
% SHModifyVtk;

%% Check SHSum

% inpath = [filepath 'output/'];
% infile = [filename '_new_r'];
% outpath = [filepath 'output/'];
% outfile = [filename '_debug'];
% 
% load([inpath infile]);
% 
% Cnm=[1 2 3 4 5 6 7 8 9];
% Snm=zeros( size(Cnm) );
% 
% r_calc=zeros( size(r) );
% 
% for i=1:NUM_NODES
%     r_calc(i)=SHSum( Cnm,Snm,theta(i), lambda(i));
% end
% 
% fid=fopen('x.txt','w');
% fprintf(fid,'%f\n',r_calc);
% fclose(fid);

%% Expand

inpath = [filepath 'output/'];
infile = [filename '_new_r'];
outpath = [filepath 'output/'];
outfile = [filename '_expand_debug'];

load([inpath infile]);

[Cnm,Snm]=SHExpand(x,y,z,r,theta,lambda,NUM_TRI,TRI,9);

savefile=[ outpath outfile ];
save(savefile,'Cnm','Snm');

%% plot the shape
% 
% theta=0:pi/50:pi;
% phi=0:pi/50:2*pi;
% [THETA,PHI]=meshgrid(theta,phi);
% R=zeros(size(THETA));
% n=6;
% m=6;
% 
% for i=1:size(THETA,1)
%     i
%     for j=1:size(THETA,2)
%         R(i,j)=SHSum(Cnm,Snm,THETA(i,j),PHI(i,j) );
%         % R(i,j)=sin(m*PHI(i,j)) .*SHPnm(n,m,THETA(i,j) ) ;
%     end
% end
% 
% X=zeros(size(THETA));
% Y=zeros(size(THETA));
% Z=zeros(size(THETA));
% 
% for i=1:size(THETA,1)
%     for j=1:size(THETA,2)
%         Z(i,j)=R(i,j)*cos(THETA(i,j));
%         X(i,j)=R(i,j)*sin(THETA(i,j))*cos(PHI(i,j)) ;
%         Y(i,j)=R(i,j)*sin(THETA(i,j))*sin(PHI(i,j)) ;
%     end
% end
% 
% scrsz = get(0,'ScreenSize');
% figure('Color',[1 1 1],'renderer','zbuffer', 'Position',[scrsz(3)/2+200 scrsz(4)/2+500 scrsz(3)/4 scrsz(4)/2])
% mesh(X,Y,Z)
% axis equal
% axis([-2 2 -2 2 -2 2])
%

%% 7/29
% filepath='~/Data/VirusTest/';
% filename='T9_3';
% 
% figure(1)
% load([filepath filename '_coordinates']);
% plot3(x,y,z,'.');
% axis equal
% axis([-2 2 -2 2 -2 2])
% mean(x.*x+y.*y+z.*z)
% 
% figure(2)
% load([filepath filename '_rotated']);
% plot3(x,y,z,'.');
% axis equal
% axis([-2 2 -2 2 -2 2])
% mean(x.*x+y.*y+z.*z)


% load([filepath filename '_expand2']);

% A=SHSum(Cnm,Snm,theta,lambda)-r;
% B=SHSum(Cnm(1:6),Snm(1:6),theta,lambda)-r;
% Z=SHSum(Cnm(1),Snm(1),theta,lambda)-r;
% 
% mean(A.*A)
% mean(B.*B)
% mean(Z.*Z)
%% Check the results
% use outline files
% 
% clc;
% 
% % read file
% 
% filepath=['T9_3_iter0.vtk'];
% 
% fid=fopen(filepath,'r');
% info_version=fgetl(fid);
% info_format=fgetl(fid);
% info_encoding=fgetl(fid);
% info_title=fgetl(fid);
% 
% % Nodes
% C=textscan(fid,'%s%d%s',1);
% NUM_NODES=C{2};
% 
% C=textscan(fid,'%f%f%f',NUM_NODES);
% outlinex=C{1};
% outliney=C{2};
% outlinez=C{3};
% 
% fclose(fid);
% 
% [outlinetheta,outlinelambda,outliner]=cart2sph(outlinex,outliney,outlinez);
% 
% resi=SHCheckSum(Cnm,Snm,outlinetheta,outlinelambda)-outliner;
% sum(resi.^2)

% resi=SHCheckSum(Cnm_2,Snm_2,outlinetheta,outlinelambda)-outliner;

%% Expand by Fitting

% Xdata=[theta,lambda];
% Ydata=r;
% 
% global NOD;
% 
% NOD=2;%number of degree
% NOPD=(NOD+1)*(NOD);
% x0=zeros(NOPD,1);
% x0(1)= 1.6455;
% 
% ff=optimset;
% ff.MaxFunEvals=50000;
% ff.MaxIter=5000;
% % ff.Algorithm=''
% 
% lb=[];
% ub=[];
% 
% [cc,resnorm,residual] = lsqcurvefit(@SHFitSum,x0,Xdata,Ydata,lb,ub,ff);

%% Visualization Nodes
% visualize by plot

% plot3(x,y,z,'.');
% axis equal

%% Check the transformation from spherical to cartesian

% clc
% 
% x=1;
% y=-1;
% z=-sqrt(2);
% 
% r=sqrt(x^2+y^2+z^2);
% theta=atan(sqrt(x^2+y^2) / z );
% if theta<0
%     theta=pi+theta;
% end
% lambda=atan2(y,x);
% 
% if lambda<0
%     lambda=2*pi+lambda;
% end
% 
% theta/pi*180
% lambda/pi*180

%% Check the transformation

% Everythings seems good

% test_x=zeros(size(x));
% test_y=zeros(size(y));
% test_z=zeros(size(z));
% 
% for i=1:NUM_NODES
%     test_z(i)=r(i)*cos(theta(i));
%     test_x(i)=r(i)*sin(theta(i))*cos(lambda(i));
%     test_y(i)=r(i)*sin(theta(i))*sin(lambda(i));
% end

%% Validating the bases

% 
% for i=1:NUM_NODES
%     r(i)=1;% theta=0:pi/50:pi;
% phi=0:pi/50:2*pi;
% [THETA,PHI]=meshgrid(theta,phi);
% R=zeros(size(THETA));
% n=6;
% m=6;
% 
% for i=1:size(THETA,1)
%     i
%     for j=1:size(THETA,2)
%         R(i,j)=SHSum(Cnm,Snm,THETA(i,j),PHI(i,j) );
%         % R(i,j)=sin(m*PHI(i,j)) .*SHPnm(n,m,THETA(i,j) ) ;
%     end
% end
% 
% X=zeros(size(THETA));
% Y=zeros(size(THETA));
% Z=zeros(size(THETA));
% 
% for i=1:size(THETA,1)
%     for j=1:size(THETA,2)
%         Z(i,j)=R(i,j)*cos(THETA(i,j));
%         X(i,j)=R(i,j)*sin(THETA(i,j))*cos(PHI(i,j)) ;
%         Y(i,j)=R(i,j)*sin(THETA(i,j))*sin(PHI(i,j)) ;
%     end
% end
% 
% scrsz = get(0,'ScreenSize');
% figure('Color',[1 1 1],'renderer','zbuffer', 'Position',[scrsz(3)/2+200 scrsz(4)/2+500 scrsz(3)/4 scrsz(4)/2])
% mesh(X,Y,Z)
% axis equal
% axis([-2 2 -2 2 -2 2])

% end
% 
% Cnm=0;
% Snm=0;
% 
% sum_C=0;
% sum_S=0;
% sum_A=0;
% sum_result=0;
% 
% m=0;
% n=0;
% 
% n1=0;
% m1=0;
% n2=0;
% m2=0;
% 
% fid=fopen('tempout.txt','w');
% 
% for n1=0:2
%     for m1=0:n1
%         for n2=0:n1
%             for m2=0:n2
% 
% 
% sum_A=0;
% sum_result=0;
% 
% for i=1:NUM_TRI
%     
%     N1=TRI(i,1)+1;
%     N2=TRI(i,2)+1;
%     N3=TRI(i,3)+1;
%     
%     v1=[x(N1)-x(N3),y(N1)-y(N3),z(N1)-z(N3)];
%     v2=[x(N2)-x(N3),y(N2)-y(N3),z(N2)-z(N3)];
%     S=norm(cross(v1,v2))/2;
%     
%     sum_A=sum_A+S;
% 
%     %i %#ok<NOPTS>
% 
%     I1=( SHPnm(n1,m1,theta(N1) )*cos(m1*lambda(N1) ) ) *( SHPnm(n2,m2,theta(N1) )*cos(m2*lambda(N1) ) )   ;
%     I2=( SHPnm(n1,m1,theta(N2) )*cos(m1*lambda(N2) ) ) *( SHPnm(n2,m2,theta(N2) )*cos(m2*lambda(N2) ) )   ;
%     I3=( SHPnm(n1,m1,theta(N3) )*cos(m1*lambda(N3) ) ) *( SHPnm(n2,m2,theta(N3) )*cos(m2*lambda(N3) ) )   ;
% 
%     sum_result=sum_result+( I1+ I2 + I3)*S/3;
%     
% end
% 
% n1,m1,n2,m2 %#ok<NOPTS>  
% sum_result/sum_A %#ok<NOPTS>                
% 
% fprintf(fid,'n1=%d m1=%d n2=%d m2=%d:\n',n1,m1,n2,m2);
% fprintf(fid,'%f\n\n',sum_result/sum_A);
%                 
%             end
%         end
%     end
% end
% 
% fclose(fid);

% clc;

% Cnm=sum_C/(sum_A);
% Snm=sum_S/(sum_A);
