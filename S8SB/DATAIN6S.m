function [EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,...
NFORCE,FORCE,NPRESS,PRESS]=DATAIN6S
%(注意)...は継続行をあらわす
%
%飛行船の応力解析
%
EYOUNG=1000;PO=0.0;NODT=21;NELT=20;RR=30*((1:11)-1);
ZZ=[-10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10];
ZZ=10*ZZ;RR=25*sqrt(1-(ZZ/100).*(ZZ/100));
TT=(1:NELT)*0+0.001;
KOTEI=[1 1 1 1 1
       2 0 1 0 0
       3 0 1 0 0
       4 0 1 0 0
       5 0 1 0 0
       6 0 1 0 0
       7 0 1 0 0
       8 0 1 0 0
       9 0 1 0 0
      10 0 1 0 0
      11 0 1 0 0
      12 0 1 0 0
      13 0 1 0 0
      14 0 1 0 0
      15 0 1 0 0
      16 0 1 0 0
      17 0 1 0 0
      18 0 1 0 0
      19 0 1 0 0
      20 0 1 0 0
      21 0 1 0 0];
NFORCE=0;FORCE=0;NPRESS=1;
PRESS=(1:NODT)*0.0+1.0;
FORCEN=[0 0 0 0 0];
