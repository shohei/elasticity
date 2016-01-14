function [SM]=STIFF(D,X,Y,T)
X1=X(1);X2=X(2);X3=X(3);Y1=Y(1);Y2=Y(2);Y3=Y(3);
A=0.5*(X2*Y3+X1*Y2+X3*Y1-X2*Y1-X3*Y2-X1*Y3);
B=zeros(3,6);
B(1,1)=Y2-Y3;B(1,3)=Y3-Y1;B(1,5)=Y1-Y2;
B(2,2)=X3-X2;B(2,4)=X1-X3;B(2,6)=X2-X1;
B(3,1)=X3-X2;B(3,2)=Y2-Y3;B(3,3)=X1-X3;
B(3,4)=Y3-Y1;B(3,5)=X2-X1;B(3,6)=Y1-Y2;
B=B/(2*A);
SM=A*T*((B') * D * B);
