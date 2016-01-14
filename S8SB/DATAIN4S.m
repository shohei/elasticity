function [EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,...
NFORCE,FORCE,NPRESS,PRESS]=DATAIN4S
%(注意)...は継続行をあらわす
%
%ミラーの例題（水平置き，PRESSで入力）
%
EYOUNG=7000000;PO=0.3;
NODT=11;NELT=10;
A11=(pi/6)*0.1*((1:11)-1);
RR=300*sin(A11);
RR(1)=0.1;
ZZ=300*(1-cos(A11));
TT=[2 2 2 2 2 2 2 2 2 2];
KOTEI=[1 1 1 1 1
       2 1 1 1 1];
NFORCE=0;
FORCE=[5 0 0 0];%ダミー入力
NPRESS=1;
PRESS=2.7*0.001*980*[TT 2];
