function [A]=ARRMAT(B,NT,MM,KY)
NS=size(KY);
LL=0;
 for NI=1:NT
   LL=LL+1;
    if sum(NI==KY)==1
      A(NI)=0;
      LL=LL-1;
    else
      A(NI)=B(LL);
    end
 end
NODT=NT/3;
A=reshape(A,3,NODT);
A=A';
