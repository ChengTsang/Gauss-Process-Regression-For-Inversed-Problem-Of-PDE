function testHyp()
[u1,u2] = meshgrid(linspace(-2,2,10)); x = [u1(:),u2(:)];
%x = gpml_randn(0.8, 20, 1);                 % 20 training inputs
  y = sin(3*x(1)) + cos(3*x(2))+0.1*gpml_randn(0.9, 20, 1) % 20 noisy training targets
  %xs = linspace(-3, 3, 61)';                  % 61 test inputs 
%We need specify the mean, covariance and likelihood functions
  meanfunc = [];                    % empty: don't use a mean function
  covfunc = @covSEiso;              % Squared Exponental covariance function
  likfunc = @likGauss;              % Gaussian likelihood
%Finally we initialize the hyperparameter struct
hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
 hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
 hyp2.cov