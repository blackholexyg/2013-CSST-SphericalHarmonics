%clc;
clear;

global num;
global filelist;
global filepath;

%% Expand by integration
% calculate the coefficients for Cnm and Snm

filename=filelist{num}  %#ok<NOPTS>
postfix='_rotated';

load([filepath filename postfix]);

% Degrees to be expanded
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

savefile=[ filepath filename '_expand2' '.mat'];
save(savefile,'Cnm','Snm');
