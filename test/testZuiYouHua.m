function testZuiYouHua()
fun=@(x)exp(1.*(x(1)-0.5).^2+(x(2)-0.7).^2);
tic
x = fminsearch(fun,[1,1])
t=toc