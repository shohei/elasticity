function MODESH(NM,AMPL,HENI,XX,YY,ZZ,KAKOM)
NELT=size(KAKOM,1);
NODT=size(XX,2);
NT=6*NODT;
AMP=0;
FREQHZ=0;
 for NE=1:NELT
   IN=KAKOM(NE,1);
     XI=XX(IN);YI=YY(IN);ZI=ZZ(IN);
   JN=KAKOM(NE,2);
     XJ=XX(JN);YJ=YY(JN);ZJ=ZZ(JN);
   X=[XI,XJ];Y=[YI,YJ];Z=[ZI,ZJ];
  plot3(X,Y,Z,':'),hold on
 end
if NM==0
else
SHI=HENI;
 LX=max(XX)-min(XX);LY=max(YY)-min(YY);LZ=max(ZZ)-min(ZZ);
 LEN=max([LX,LY,LZ]);
 XS=SHI(1:NODT,1)';
 YS=SHI(1:NODT,2)';
 ZS=SHI(1:NODT,3)';
AMP=AMPL*LEN;
%
 XS=XX+XS*AMP;
 YS=YY+YS*AMP;
 ZS=ZZ+ZS*AMP;
 for NE=1:NELT
   IN=KAKOM(NE,1);
     XI=XS(IN);YI=YS(IN);ZI=ZS(IN);
   JN=KAKOM(NE,2);
     XJ=XS(JN);YJ=YS(JN);ZJ=ZS(JN);
   X=[XI,XJ];Y=[YI,YJ];Z=[ZI,ZJ];
  plot3(X,Y,Z),hold on
 end
axis('equal')
hold off
end
