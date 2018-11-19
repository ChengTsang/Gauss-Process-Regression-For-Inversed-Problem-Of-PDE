## Gauss Progress Regression for Solving Inverse Problem of PDE

Using Bayesian framework to solve PDE inverse problem is a classical method. In this program, I use GPR as an approximation function, which improves the time efficiency of Bayesian framework by five times and obtains the same results as traditional methods. You can learn more details from this article.

This program is a highly modular program, you can change the PDE equation of the original problem into any equation you want without any other modification.

### Result：
From the demo I given in my test modular, we could see it is easy for GPR to fir arbitrary functions. It can even give the 95% confidence interval.

![在这里插入图片描述](https://img-blog.csdnimg.cn/20181119112810600.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTY3OTQxMQ==,size_9,color_FFFFFF,t_70)
back to the main program, from the figure below, we could also see the process of sampling.

![在这里插入图片描述](https://img-blog.csdnimg.cn/20181119113656957.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTY3OTQxMQ==,size_16,color_FFFFFF,t_70)

the reslut for the distribution of parameters are here:
![在这里插入图片描述](https://img-blog.csdnimg.cn/2018111911384324.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTY3OTQxMQ==,size_16,color_FFFFFF,t_70)

### Usage
 you can use regAndPre function to implement my program.
a. When there is no parameter, the first part is to provide data for training, and it needs to solve many times PDE.
	regAndPre()
	
b. When there is a parameter, second parts are executed to transform between the matrix and the vector.

c. when there are 5 parameters , third parts perform and get the observation vector.
	regAndPre(x0,y0,yadta,A,Hyp)
	
when you need to use your own pde, you need only change the ThomasAlgorithm.m and DYakonov_DiffMethod.m program. You should pay attention to the data frame for the input and output.

### Dependencies
1. GP
2.  MCMC
those are useful in matlab toolbox 
