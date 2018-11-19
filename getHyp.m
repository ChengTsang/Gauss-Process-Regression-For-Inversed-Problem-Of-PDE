function hyp=getHyp(Udata)
x1 = linspace(0.1,1,10); x2 = linspace(0.1,1,10);
  x = apxGrid('expand',{x1',x2'});
  %y = sin(x(:,2)) + x(:,1) + 0.1*gpml_randn(1,[size(x,1),1]);
  y=Udata;
% 20 training inputs
%[u1,u2] = meshgrid(gpml_randn(0.8, 20, 1)); x = [u1(:),u2(:)];
  %y = sin(3*x(1))+x(2) + 0.1*gpml_randn(0.9, 20, 1);  % 20 noisy training targets
  %xs = linspace(-3, 3, 61)';                  % 61 test inputs 
%We need specify the mean, covariance and likelihood functions
  meanfunc = [];                    % empty: don't use a mean function
  covfunc = @covSEiso;              % Squared Exponental covariance function
  likfunc = @likGauss;              % Gaussian likelihood
%Finally we initialize the hyperparameter struct
  hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
  hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
  hyp=[hyp2.cov,hyp2.lik];
  %xs=[1,1];
  %[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
  %mu;