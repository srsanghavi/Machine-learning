clear all;
N=3; %specify order of the curve
n=256;
%image reading and histogram calculation
img=imread('D:/lena.jpg');
hist=imhist(img);
y=transpose(hist);
x=1:256;

%sigma(X^n) calculation
sX=zeros(2*N);
for j=1:2*N
    for i=1:256
        sX(j)=sX(j)+x(i)^j;
    end
end
sx=transpose(sX(:,1));
%building a matrix A
A=zeros(N,N);
for i=1:N+1
    z=i-1;
    for j=1:N+1
        if i==1 && j==1
            A(i,j)=n;
        else
            A(i,j)=sx(z);
        end
           z=z+1;
    end
end

%sigmaX^(n)*Y calculation
sY=zeros(N+1);
for j=1:N+1
    for i=1:256
        sY(j)=sY(j)+x(i)^(j-1)*y(i);
    end
end

sy=sY(:,1);
%calculating cooficients
p=A\sy;

p=transpose(p);
 for i=1:size(p,2)
     P(i)=p(size(p,2)-i+1);
 end
%generating curve a0+a1X+a2X^2...+anX^n
f = polyval(P,x);
plot(x,y,'.',x,f,'-')
