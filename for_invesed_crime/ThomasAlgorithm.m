function u=ThomasAlgorithm(A,f)
%追赶法求解三对角矩阵A*u=f
%input:A,f
%output:u
[m,n]=size(A);
g=zeros(n,1);w=zeros(n,1);u=zeros(n,1);
alpha=diag(A,-1);beta=diag(A);gamma=diag(A,1);
g(1)=f(1)/beta(1);w(1)=gamma(1)/beta(1);
for i=2:n-1
    g(i)=(f(i)-alpha(i-1)*g(i-1))/(beta(i)-alpha(i-1)*w(i-1));
    w(i)=gamma(i)/(beta(i)-alpha(i-1)*w(i-1));
end
g(n)=(f(n)-alpha(n-1)*g(n-1))/(beta(n)-alpha(n-1)*w(n-1));
u(n)=g(n);
for i=n-1:-1:1
    u(i)=g(i)-w(i)*u(i+1);
end