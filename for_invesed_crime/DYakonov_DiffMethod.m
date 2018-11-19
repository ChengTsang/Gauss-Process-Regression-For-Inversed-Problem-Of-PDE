function [U,u,err]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun)
%D'Yakonov交替方向隐格式
%输入:[m,n]等分数,ut初始条件,ux,uy边界条件,fun右端函数,realfun精确解
%输出:u数值解,U精确解,err误差
h=1/m;tau=T/n;r=tau/h^2;
x=linspace(0,1,m+1);y=linspace(0,1,m+1);t=linspace(0,T,n+1);
[x0,y0]=meshgrid(x,y);u=zeros(m+1,m+1,n+1);
u(:,:,1)=ut(x0,y0);U(:,:,1)=realfun(x0,y0,0);   %u(j,i,k),U(j,i,k)
[x0,t0]=meshgrid(x,t);
u(1,:,:)=uy0(x0,t0)';u(m+1,:,:)=uy1(x0,t0)';
[y0,t0]=meshgrid(y,t);
u(:,1,:)=ux0(y0,t0)';u(:,m+1,:)=ux1(y0,t0)';
[x0,y0]=meshgrid(x,y);
dd=-r/2.*ones(m-2,1);d=(1+r).*ones(m-1,1);
A=diag(d)+diag(dd,1)+diag(dd,-1);
for k=1:n
    U(:,:,k+1)=realfun(x0,y0,t(k+1));
    for j=1:m-1
        f=fun(x(2:end-1),y(j+1),t(k))+fun(x(2:end-1),y(j+1),t(k+1));
        li=u(j+1,1:end-2,k)-2.*u(j+1,2:end-1,k)+u(j+1,3:end,k);
        li=li+u(j,2:end-1,k)-2.*u(j+1,2:end-1,k)+u(j+2,2:end-1,k);
        f=(tau/2).*f+u(j+1,2:m,k)+(r/2).*li;
        li=u(j,:,k)-2.*u(j+1,:,k)+u(j+2,:,k);
        li=li(1:end-2)-2.*li(2:end-1)+li(3:end);
        f=f+(r^2/4).*li;f(1)=f(1)-r*(r/2*u(j,1,k+1)-(1+r)*u(j+1,1,k+1)+r/2*u(j+2,1,k+1))/2;
        f(end)=f(end)-r*(r/2*u(j,end,k+1)-(1+r)*u(j+1,end,k+1)+r/2*u(j+2,end,k+1))/2;
        temp(:,j)=ThomasAlgorithm(A,f');
    end
    for i=1:m-1
        f=temp(i,:);
        f(1)=f(1)+r*u(1,i+1,k+1)/2;f(end)=f(end)+r*u(end,i+1,k+1)/2;
        u(2:end-1,i+1,k+1)=ThomasAlgorithm(A,f');
    end
end
err=abs(u-U);