function ym=demoGrid2d_2(Udata)
%x1 = linspace(-2,2,120); x2 = linspace(-3,3,130);
x1 = linspace(0.01,1,100); x2 = linspace(0.01,1,100);
x = apxGrid('expand',{x1',x2'});
  %y = sin(x(:,2)) + x(:,1) + 0.1*gpml_randn(1,[size(x,1),1]);
  y=Udata;
%Then, we define the locations where we would like to have the predictions i.e. a [-4,4]x[-6,6] lattice to see the result of the extrapolation.
  xs1 = linspace(0.01,1,100); xs2 = linspace(0.01,1,100);
  xs = apxGrid('expand',{xs1',xs2'});
%Next, we construct the grid for KISS/SKI GP using an auxiliary function so that both training data x and the test data xs are properly covered.
  xg = apxGrid('create',[x;xs],true,[50,70]);
%Now that the data set is well-defined, we specify our GP model along with initial values for the hyperparameter by wrapping the covariance functions into apxGrid, GPML's grid-based covariance approximation method.

  cov = {{@covSEiso},{@covSEiso}}; covg = {@apxGrid,cov,xg};
  mean = {@meanZero}; lik = {@likGauss};
  hyp.cov = zeros(4,1); hyp.mean = []; hyp.lik = log(0.1);
%As a next step, we perform hyperparameter optimisation as with a usual GP model using the inference method infGaussLik which only supports likGauss. In order to do so, we specify parameters for the LCG: the maximum number of iterations and the convergence threshold via the opt variable.
  opt.cg_maxit = 200; opt.cg_tol = 5e-8;
  infg = @(varargin) infGaussLik(varargin{:},opt);
  hyp = minimize(hyp,@gp,-50,infg,[],covg,[],x,y);
  hyp.cov
%Finally, we make use of grid interpolation to compute predictions very rapidly with the post.predict utility provided by the infGrid method.

  [post,nlZ,dnlZ] = infGrid(hyp,{@meanZero},covg,{@likGauss},x,y,opt);
  
  [fm,fs2,ym,ys2] = post.predict(xs);
  ym;
  
%Alternatively, we can use the usual pathway based on gp,
  post.L = @(a) zeros(size(a));
  tic
  ym = gp_2(hyp,infg,[],covg,[],x,post,xs);
  t=toc
  length(ym);