function [TK,FNT,MM,KY]=prerea1(TK,FNT,NT,KOTEI)
[NFIX,K]=size(KOTEI);
  III=0;
 for N=1:NFIX
  NODE=KOTEI(N,1);
    for JI=2:3
     if KOTEI(N,JI) ~=0 
      III=III+1;
      KY(III)=((NODE-1)*2-1)+JI;
     else
     end
   end
 end 
NOFIX=III;   
INDEX=1:NT;
  INDEX(KY)=zeros(size(KY));
MM=0;
 for N=1:NT
  if INDEX(N) ~= 0
    MM=MM+1;
    INDEX(MM)=N;
  else
  end
 end
%
INDEX=INDEX(1:MM);
FNT=FNT(INDEX);
TK=TK(INDEX,INDEX);
