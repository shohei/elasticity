function [TK1,TK2,TK3,FN1,MM,IM,IS]=PREREA3(TK,FN,NT,KOTEI)
INDEX=1:NT;
[NFIX,K]=size(KOTEI);
  III=0;
 for N=1:NFIX
  NODE=KOTEI(N,1);
    for JI=2:4
     if KOTEI(N,JI) ~=0 
      III=III+1;
      INDEX(((NODE-1)*3-1)+JI)=0;
     else
     end
   end
 end 
NOFIX=III;MM=NT-NOFIX;
IM=find(INDEX);   
for I=1:NT
 if INDEX(I)==0
    INDEX(I)=NT+3;
   else
  end
end
 ISS=(INDEX>NT);
IS=find(ISS);
INDEX=IM;
TK1=TK(IM,IM);FN1=FN(IM);
TK2=TK(IS,IM);TK3=TK(IS,IS);
