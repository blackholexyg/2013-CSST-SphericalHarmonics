function [ Sum ] = SHFitSum( cc,X )
%SHFITSUM Calculates the approximation of series expansion of spherical
%harmonics
%   Detailes

global NOD;

N=NOD;
theta=X(:,1);
lambda=X(:,2);
Sum=0;

HalfNOPD=(N+1)*N/2;
k=0;

for n=0:N-1    
    Pn=sqrt(2)*legendre(n,cos(theta),'norm');
    for m=0:n
        k=k+1;
        Pmn=Pn(m+1,:)';
        Sum=Sum+( cc(k)*cos(m*lambda) + cc(k+HalfNOPD)*sin(m*lambda) ).*Pmn ;
    end
end

end
