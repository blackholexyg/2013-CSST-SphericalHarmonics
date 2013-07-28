function [Pnm]=SHPnm(n,m,theta)

Pn=legendre(n,cos(theta));

if m>0
    C=sqrt(2*(2*n+1)*factorial(n-m)/factorial(n+m));
end

if m==0
    C=sqrt((2*n+1)*factorial(n-m)/factorial(n+m));
end

Pnm= C * Pn(m+1);

end