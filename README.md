## Gauss Progress Regression for Solving Inverse Problem of PDE
![](https://img.shields.io/badge/language-matlab-red.svg) 
![](https://img.shields.io/badge/license-MIT-000000.svg)


Using Bayesian framework to solve PDE inverse problem is a classical method. In this program, I use GPR as an approximation function, which improves the time efficiency of Bayesian framework by five times and obtains the same results as traditional methods. You can learn more details from this article：http://iopscience.iop.org/article/10.1088/1361-6420/aae04f/meta

This program is a highly modular program, you can change the PDE equation of the original problem into any equation you want without any other modification.

### Result：
From the demo I given in my test modular, we could see it is easy for GPR to fir arbitrary functions. It can even give the 95% confidence interval.
<div align=center>
<img src="https://img-blog.csdnimg.cn/20181119112810600.jpg" width=50% height=50% /> 
</div align>

back to the main program, from the figure below, we could also see the process of sampling.
<div align=center>
<img src="https://img-blog.csdnimg.cn/20181119113656957.jpg" width=50% height=50% /> 
</div align>
the reslut for the distribution of parameters are here:
<div align=center>
<img src="https://img-blog.csdnimg.cn/2018111911384324.jpg" width=50% height=50% /> 
</div lign>

### Usage
 you can use regAndPre function to implement my program.

a. When there is no parameter, the first part is to provide data for training, and it needs to solve many times PDE.
```	
regAndPre()
```	
b. When there is a parameter, second parts are executed to transform between the matrix and the vector.

c. when there are 5 parameters , third parts perform and get the observation vector.
```	
regAndPre(x0,y0,yadta,A,Hyp)
```	
when you need to use your own pde, you need only change the ThomasAlgorithm.m and DYakonov_DiffMethod.m program. You should pay attention to the data frame for the input and output.

### Dependencies
1. GP
2.  MCMC

those are useful in matlab toolbox 
