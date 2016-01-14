function[F,RAMDA,ITE]=SUBSPA(K,M,N,NEIG)
RAMDA=zeros(NEIG,1);
F=rand(N,NEIG);
Y=zeros(N,NEIG);
for ITE=1:50
 RAMOLD=RAMDA;
 Z=M * F;
  for I=1:NEIG
   YI=K\Z(1:N,I);
   Y(1:N,I)=YI;
  end
 KG=Y' * K * Y;
 MG=Y' * M * Y;
 [V,D]=eig(KG,MG);
  for I=1:NEIG
   RAMDA(I,1)=real(D(I,I));
  end
   ITE
   RAMDA'
 HAN=abs((RAMDA-RAMOLD)/RAMDA);
 if max(HAN)<=0.00002 , break,end
F=real(Y * V);
 for I=1:NEIG
  FMAX=max(abs(F(1:N,I)));
  F(1:N,I)=F(1:N,I)/FMAX;
 end
end
