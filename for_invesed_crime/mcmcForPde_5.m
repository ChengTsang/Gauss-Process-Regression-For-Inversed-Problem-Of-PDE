function mcmcForPde_5()
%此例配合regAndPre_5，试图以矩阵传递数据
clear data model options
udata=fun5_1(0.4,0.6);
%global conts;
load('A.mat')
for i=1:1:121
     A1(:,i)=A{i};
end
save('A1.mat','A1')
length(A{1});
load('Hyp.mat')

 for i=1:1:121
     Hyp1(i,:)=Hyp{i};
 end
save('Hyp1.mat','Hyp1')
%err=0.001*randn(11);
err = normrnd(0,0.001,11);
udataWithErr=udata+err;
udata1=@(par)fun5_1(par(1),par(2));
%udata1=@(par,A1,Hyp1)regAndPre_5(par(1),par(2),A1,Hyp1);
%ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par,A1,Hyp1)).^2);
ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par)).^2);
params = {
    {'par1', 0.2, 0}
    {'par2', 0.4, 0}
    };
model.ssfun = ssfun;
options.nsimu = 10000;
options.updatesigma = 1;
[res,chain,s2chain] = mcmcrun(model,udataWithErr,params,options);
chainstats(chain,res)
% mcmcplot(chain(:,1),[],res,'denspanel',2)
% figure(1); clf
% mcmcplot(chain,[1,2],res.names,'pairs',0)
udata=fun5_1(0.4,0.6);
%global conts;
load('A.mat')
for i=1:1:121
     A1(:,i)=A{i};
end
save('A1.mat','A1')
length(A{1});
load('Hyp.mat')

 for i=1:1:121
     Hyp1(i,:)=Hyp{i};
 end
save('Hyp1.mat','Hyp1')
%err=0.001*randn(11);
%err = normrnd(0,0.01,11);
%udataWithErr=udata+err;
%udata1=@(par)fun5_1(par(1),par(2));
udata1=@(par,A1,Hyp1)regAndPre_5(par(1),par(2),A1,Hyp1);
ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par,A1,Hyp1)).^2);
%ssfun=@(par,udataWithErr)sum((udataWithErr-udata1(par)).^2);
params = {
    {'par1', 0.2, 0}
    {'par2', 0.4, 0}
    };
model.ssfun = ssfun;
options.nsimu = 10000;
options.updatesigma = 1;
[res2,chain2,s2chain2] = mcmcrun(model,udataWithErr,params,options);
chainstats(chain2,res2)
figure(1); clf;%chain(:,1)
mcmcplot(chain(:,2),[],res,'denspanel',2);hold on;
mcmcplot(chain2(:,2),[],res2,'denspanel',2);
hold off;
figure(2); clf;%chain(:,1)
mcmcplot(chain(:,1),[],res,'denspanel',2);hold on;
mcmcplot(chain2(:,1),[],res2,'denspanel',2);
hold off;
