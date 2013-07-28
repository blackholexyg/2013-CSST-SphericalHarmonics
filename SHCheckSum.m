function [ Sum ] = SHCheckSum( Cnm,Snm,theta, lambda)
%SHFITSUM Calculates the approximation of series expansion of spherical
%harmonics
%   Detailes

Sum=0;

Dim=length(Cnm);
N=(  (-1+sqrt(1+8*Dim))/2 );

k=0;

for n=0:N-1    
    for m=0:n
        k=k+1;
        Sum=Sum+( Cnm(k)*cos(m*lambda) + Snm(k)*sin(m*lambda) ).*SHPmn(m,n,theta) ;
    end
end

end
