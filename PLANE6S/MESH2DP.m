function MESH2DP(AMP,STRESS)
[XY,D,FORCE,KOTEI,KAKOM,T]=DATAIN4;
[NODT,DIM]=size(XY);
[NELT,KAKU]=size(KAKOM);
[NOFIX,JIYU]=size(KOTEI);
NT=NODT*(JIYU-1);
%
for NE=1:NELT
  K3=KAKOM(NE,1:3);
  X=XY(K3,1);Y=XY(K3,2);
  plot(X,Y),hold on
end
SC2=max(abs(STRESS(:,[4 5])));
SC=max(SC2);
AMAX=max(XY)/sqrt(NELT);A=AMAX*AMP/SC;
for NE=1:NELT
  K3=KAKOM(NE,1:3);
  XG=sum(XY(K3,1))/3;YG=sum(XY(K3,2))/3;
  S1=STRESS(NE,4);S2=STRESS(NE,5);TC=STRESS(NE,6);
 X11=XG-A*S1*cos(TC);X12=XG+A*S1*cos(TC);
 Y11=YG-A*S1*sin(TC);Y12=YG+A*S1*sin(TC);
 plot([X11 X12],[Y11 Y12]),hold on
TS=TC+0.5*pi;
 X21=XG-A*S2*cos(TS);X22=XG+A*S2*cos(TS);
 Y21=YG-A*S2*sin(TS);Y22=YG+A*S2*sin(TS);
 plot([X21 X22],[Y21 Y22]),hold on
end
 hold off
