function [TM]=TMATR(X,Y,TT)
TM=zeros(9,9);
for IVIP=1:3
X1=X(IVIP);
Y1=Y(IVIP);
J=IVIP+1;
 if (J == 4)
   J=1;
 else
 end
X2=X(J);
Y2=Y(J);
TI=TIMAT(X1,X2,Y1,Y2,IVIP,TT);
TM=TM+TI;
end
