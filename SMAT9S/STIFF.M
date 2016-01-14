function [SM]=STIFF(D,X,Y,T)
H=HMAT(D,X,Y,T);
HI=inv(H);
TM=TMATR(X,Y,T);
SM=(TM') * real(HI') * TM;
