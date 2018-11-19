function udata=fun5_1(par1,par2)

%ËãÀý5.1
%udata=par1;
clc;
%clear all;
%par1
%par2
ut=inline('exp((x+y)./2)','x','y');
ux0=inline('exp(y./2-t)','y','t');
ux1=inline('exp((1+y)./2-t)','y','t');
uy0=inline('exp(x./2-t)','x','t');
uy1=inline('exp((1+x)./2-t)','x','t');
%fun=inline('exp(-1.*(x-par1).^2-(y-par2).^2-t)','x','y','t');
fun=@(x,y,t)exp(-1.*(x-par1).^2-(y-par2).^2-t);
realfun=inline('exp((x+y)./2-t)','x','y','t');
%---±í5.1---%
T=1;
% m1=100;n1=100;
% [U1,u1,err1]=DYakonov_DiffMethod(m1,n1,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
% i=[26,76];A0=[];A1=[];err1=[];
% for k=26:25:101
%     A0=[A0;U1(26,i,k)'];A0=[A0;U1(76,i,k)'];
%     A1=[A1;u1(26,i,k)'];A1=[A1;u1(76,i,k)'];
% end
% err1=abs(A0-A1);A=[A1,A0,err1];
%xlswrite('A.xls',A);
%---±í5.2ºÍÍ¼5.2,5.3,5.4---%
m=10;n=10;[U2,u2,err2]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
%m=20;n=20;[U3,u3,err3]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
%m=40;n=40;[U4,u4,err4]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
%m=80;n=80;[U5,u5,err5]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
%m=160;n=160;[U6,u6,err6]=DYakonov_DiffMethod(m,n,T,ut,ux0,ux1,uy0,uy1,fun,realfun);
%D(1,1)=max(max(max(err2)));D(2,1)=max(max(max(err3)));
%D(3,1)=max(max(max(err4)));D(4,1)=max(max(max(err5)));
%D(5,1)=max(max(max(err6)));
%D(2:5,2)=D(1:4,1)./D(2:5,1);
%xlswrite('D.xls',D);
% x1=linspace(0,1,11);x2=linspace(0,1,21);x3=linspace(0,1,41);
% y1=linspace(0,1,11);y2=linspace(0,1,21);y3=linspace(0,1,41);
% x1=x1(2:end-1);x2=x2(2:end-1);x3=x3(2:end-1);
% y1=y1(2:end-1);y2=y2(2:end-1);y3=y3(2:end-1);
%figure;mesh(y1,x1,U2(2:end-1,2:end-1,end));
%xlabel('x');ylabel('y');zlabel('U(x,y,1)');hold on;
% figure;mesh(y1,x1,u2(2:end-1,2:end-1,end));
% xlabel('x');ylabel('y');zlabel('u(x,y,1)');hold on;
%figure;mesh(y1,x1,err2(2:end-1,2:end-1,end));hold on;
%mesh(y2,x2,err3(2:end-1,2:end-1,end));hold on;
%mesh(y3,x3,err4(2:end-1,2:end-1,end));hold on;
%xlabel('x');ylabel('y');zlabel('|u(x,1)-U(x,1)|');
%legend('h=\tau=1/10','h=\tau=1/20','h=\tau=1/40');
%disp('11111111')
udata=u2(1:end,1:end,3);
% err=sqrt(0.001)*rand(11);
% udata=u2(1:end,1:end,3)+err;
% xlswrite('tureDataWithErr.xls',udata);