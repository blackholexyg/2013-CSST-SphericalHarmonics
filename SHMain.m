% clc,clear

%% Preprocessing
% Here I read in all the data needed

% initialization
clc,clear

global ID;
global num;

ID(num) 

% the file path and name 
filepath='';
filename='T9_3_iter';
postfix='.vtk';

fid=fopen([filepath filename num2str(ID(num)) postfix],'r');

% read file
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


%% Expand by integration
% calculate the coefficients for Cnm and Snm


N=10;
Dim=(N+1)*(N)/2;
Cnm=zeros(Dim,1);
Snm=zeros(Dim,1);

k=0;

for n=0:N-1  
    n  %#ok<NOPTS>
    for m=0:n
        m %#ok<NOPTS>
        
        k=k+1;
       
        sum_C=0;
        sum_S=0;
        sum_A=0;
        
        for i=1:NUM_TRI
            N1=TRI(i,1)+1;
            N2=TRI(i,2)+1;
            N3=TRI(i,3)+1;
            v1=[x(N1)-x(N3),y(N1)-y(N3),z(N1)-z(N3)];
            v2=[x(N2)-x(N3),y(N2)-y(N3),z(N2)-z(N3)];
            S=norm(cross(v1,v2))/2;
          
            sum_A=sum_A+S;
            
            I1_C=r(N1)*SHPnm(n,m,theta(N1) )*cos(m*lambda(N1) );
            I2_C=r(N2)*SHPnm(n,m,theta(N2) )*cos(m*lambda(N2) );
            I3_C=r(N3)*SHPnm(n,m,theta(N3) )*cos(m*lambda(N3) );
            
            sum_C=sum_C+( I1_C+ I2_C + I3_C)*S/3;
            
            I1_S=r(N1)*SHPnm(n,m,theta(N1) )*sin(m*lambda(N1) );
            I2_S=r(N2)*SHPnm(n,m,theta(N2) )*sin(m*lambda(N2) );
            I3_S=r(N3)*SHPnm(n,m,theta(N3) )*sin(m*lambda(N3) );
            
            sum_S=sum_S+( I1_S+ I2_S + I3_S)*S/3;
                    
        end       
        
        
        Cnm(k)=sum_C/(sum_A);
        Snm(k)=sum_S/(sum_A);
        
    end
end

savefile=[num2str(ID(num)) '.mat'];
save(savefile,'Cnm','Snm');

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

%% Visualization
% visualize by plot

% plot3(x,y,z,'.');
% axis equal




%% Validating the transformation from spherical to cartesian
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


%% Validating the bases

% 
% for i=1:NUM_NODES
%     r(i)=1;
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