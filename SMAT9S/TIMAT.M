function [TI]=TIMAT(X1,X2,Y1,Y2,IVIP,TT)
R=sqrt((X2-X1)^2+(Y2-Y1)^2);
CS=(X2-X1)/R;
SN=(Y2-Y1)/R;
PA=[1  0  0  0  0 
    X1 0  0  1  0
    Y1 0  0  0  0
    0  1  0  0  0
    0 X1  0  0  0
    0 Y1  0  0  1
    0  0  1  0  0
    0  0 X1  0  1
    0  0 Y1  1  0];
PB=[0 0 0 0 0
   CS 0 0 0 0
   SN 0 0 0 0
   0  0 0 0 0
   0 CS 0 0 0
   0 SN 0 0 0
   0 0 0 0 0
   0 0 CS 0 0
   0 0 SN 0 0];
TR=[0 CS*SN -SN^2
   0 -SN*CS -CS^2
   0  SN^2-CS^2 2*SN*CS
  -SN  0         0 
   CS  0         0];
EA=[0.5 R/12 0   0.5 -R/12 0
   -1/R  0   0   1/R   0   0
    0    0   0.5  0    0  0.5];
EB=[0.15 R/30  0 0.35 -R/20 0
   -0.5/R -1/12 0 0.5/R 1/12 0
    0     0   1/6  0    0   1/3];
SEKI=SEKIBUN(CS,SN,IVIP);
E1=EA * SEKI;
E2=EB * SEKI;
W=PA * TR;
V=PB * TR;
T1=W * E1;
T2=V * E2;
TI=T1+T2*R; 
BUS=R*TT*TT*2/3;
TI=BUS*TI;
