function MODESH(NM,AMPP,DISP3,XX,YY,ZZ,KAKOM)
%NM=0;変形前の図のみ　NM=1:変形後と重ね書き
%AMPP は通常1を入れておく．大きな数値で変形を誇張する
NELT=size(KAKOM,1);NODT=size(XX,2);NT=3*NODT;
AMP=0;
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
 LX=max(XX)-min(XX);LY=max(YY)-min(YY);
LZ=max(ZZ)-min(ZZ);
 LEN=max([LX,LY,LZ]); XS=DISP3(1:NODT,1)';
 YS=DISP3(1:NODT,2)'; ZS=DISP3(1:NODT,3)';
AMP=AMPP*LEN;
%
 XS=XX+XS*AMP; YS=YY+YS*AMP; ZS=ZZ+ZS*AMP;
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
