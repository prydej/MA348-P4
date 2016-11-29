%build matrix to find c
for i=1:11
   h1=(x(i+1)-x(i));
   h2=(x(i+2)-x(i+1));
   
   matrix(i,i)=(2*(h1+h2));
   if i<11
   matrix(i,i+1)=h2;
   end
   if i>1
   matrix(i,i-1)=h1;
   end
end

%build vector on right side
for j=1:11
    f1=(y(j+1)-y(j))/(x(j+1)-x(j));
    f2=(y(j+2)-y(j+1))/(x(j+2)-x(j+1));
    
    c(j) = f2-f1;
end 

matrix(:,12)=c;
%use gaussian elimination to find c
run('Gaussian_Elimination_Example.m')

c_ans=[0;c_ans];
c_ans(13)=0;

%loop to find d
d=zeros(12,1);
for k=1:12
   h_k=(x(k+1)-x(k)); 
   d(k)=(c_ans(k+1)-c_ans(k))/(3*h_k); 
end

%loop to find b
b=zeros(12,1);
for l=1:12
b(l)=((y(l+1)-y(l))/(x(l+1)-x(l)))-...
	((2/3)*c_ans(l)*(x(l+1)-x(l)))-...
	((1/3)*c_ans(l+1)*(x(l+1)-x(l)));
end
%build and plot Si
figure;
hold on;
ytotal=0;
for t = 1:12
   f =  @(q) y(t)+b(t).*(q-x(t))+...
   	c_ans(t).*(q-x(t)).^2+d(t)*(q-x(t)).^3;
   q0=linspace(x(t),x(t+1));
   y0= f(q0);
   plot(q0,y0,'r')
   ytotal=[ytotal,y0];
end
ytotal(1)=[];
axis equal 
plot(x,y,'bo')
hold off

%use MATLAB's spline function to compare
xx = linspace(x(1),x(13),1200);

yy = spline(x,y,xx);

figure;
plot(x,y,'x',xx,yy,'b')
axis equal

figure;
plot(x,y,'x',xx,yy,'b',q0,y0,'r')
axis equal

%find error
difference = ytotal-yy;
error=sum(difference)/1200;
