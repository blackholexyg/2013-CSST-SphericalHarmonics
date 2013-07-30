function [ Sum ] = SHSum( Cnm,Snm,theta, lambda)
%SHSUM Summary of this function goes here
%   Detailed explanation goes here

Sum=zeros(size(theta));
m=0;
n=0;

for k=1:length(Cnm)
    
    Sum=Sum+( Cnm(k)*cos(m*lambda) + Snm(k)*sin(m*lambda) ).*SHPnm(n,m,theta) ;
    
    if n==m
        n=n+1;
    elseif n>m
        m=m+1;
    end
    
end

