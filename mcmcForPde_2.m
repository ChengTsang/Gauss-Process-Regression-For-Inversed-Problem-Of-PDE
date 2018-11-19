function mcmcForPde_2()
clear data model options
udata=fun5_1(0.5,0.75)
global conts;
conts=1;
load('ydata.mat')
ydata{1};
load('A.mat')
   %     load('K.mat')
load('Hyp.mat')
err=0.001*randn(11);
udataWithErr=udata+err;
udata1=@(par)fun5_1(par(1),par(2));
%udata1=@(par,ydata,A,Hyp)regAndPre_2(par(1),par(2),ydata,A,Hyp);
ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par)).^2);
params = {
    {'par1', 0.1, 0}
    {'par2', 0.1, 0}
    };
model.ssfun = ssfun;
%model.sigma2 = 0.1^2;
options.nsimu = 10000;
options.updatesigma = 1;
[res,chain,s2chain] = mcmcrun(model,udataWithErr,params,options);
chainstats(chain,res)
% figure(1); clf
% mcmcplot(chain,[1:2],res.names,'chainpanel');
data.x0=[0,0];
[Sig,Lam] = covcond(100,ones(2,1));
data.Lam = Lam;
d    = mahalanobis(chain(:,1:2),data.x0,Lam,1);
c50  = chiqf(0.50,2);
c75  = chiqf(0.75,2);
cc50 = sum(d<c50)./1000;
cc75 = sum(d<c75)./1000;
% figure(2); clf
% mcmcplot(chain,[1,2],res.names,'pairs',0)

% title(sprintf('Rejected = %.1f%%, c50 = %.1f%%, c95 = %.1f%%, \\tau*t=%.1f', ...
%               results.rejected*100, cc50*100, cc95*100, ...
%               results.simutime/results.nsimu*1000*mean(iact(chain))))

%   hold on
%   ellipse(res.mean,c50*res.cov,'r--','LineWidth',2);
%   ellipse(res.mean,c75*res.cov,'r-','LineWidth',2);
%   axis equal
% hold off

%clear data model options
udata=fun5_1(0.5,0.75);
global conts;
conts=1;
load('ydata.mat')
ydata{1};
load('A.mat')
   %     load('K.mat')
load('Hyp.mat')
err=0.001*randn(11);
udataWithErr=udata+err;
%udata1=@(par)fun5_1(par(1),par(2));
udata1=@(par,ydata,A,Hyp)regAndPre_2(par(1),par(2),ydata,A,Hyp);
ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par,ydata,A,Hyp)).^2);
params = {
    {'par1', 0.1, 0}
    {'par2', 0.1, 0}
    };
model.ssfun = ssfun;
%model.sigma2 = 0.1^2;
options.nsimu = 10000;
options.updatesigma = 1;
[res2,chain2,s2chain] = mcmcrun(model,udataWithErr,params,options);
chainstats(chain2,res)
% figure(1); clf
% mcmcplot(chain,[1:2],res.names,'chainpanel');
data.x0=[0,0];
[Sig,Lam] = covcond(100,ones(2,1));
data.Lam = Lam;
d    = mahalanobis(chain(:,1:2),data.x0,Lam,1);
c50  = chiqf(0.50,2);
c75  = chiqf(0.75,2);
cc50 = sum(d<c50)./1000;
cc75 = sum(d<c75)./1000;
% figure(2); clf
% mcmcplot(chain,[1,2],res.names,'pairs',0)

% title(sprintf('Rejected = %.1f%%, c50 = %.1f%%, c95 = %.1f%%, \\tau*t=%.1f', ...
%               results.rejected*100, cc50*100, cc95*100, ...
%               results.simutime/results.nsimu*1000*mean(iact(chain))))

%   hold on
%   ellipse(res.mean,c50*res.cov,'r--','LineWidth',2);
%   ellipse(res.mean,c75*res.cov,'r-','LineWidth',2);
%   axis equal
% hold off
figure(1); clf;%chain(:,1)
mcmcplot(chain(:,1),[],res,'denspanel',2);hold on;
% %figure(2);clf;
mcmcplot(chain2(:,1),[],res2,'denspanel',2);
hold off;
figure(2); clf;%chain(:,1)
mcmcplot(chain(:,2),[],res,'denspanel',2);hold on;
% %figure(2);clf;
mcmcplot(chain2(:,2),[],res2,'denspanel',2);
hold off;

