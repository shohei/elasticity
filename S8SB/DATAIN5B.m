function [EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,...
NFORCE,FORCE,NPRESS,PRESS]=DATAIN5B
%(注意)...は継続行をあらわす
%
%加速度を受ける円筒シェルの軸圧縮座屈(DATAIN1と次元は同じ)
EYOUNG=7000;PO=0.3;
NODT=21;NELT=20;
RR=100+0*(1:NODT);
ZZ=(160/NELT)*((1:NODT)-1);
TT=1+0*(1:NELT);
KOTEI=[1 0 0 1 0;11 1 0 0 0;21 0 0 1 0];
%KOTEI=[1 1 1 1 1];
%KOTEI=[1 1 1 1 0];
%加速度による力 mg
NFORCE=21;
FORCE=zeros(21,5);
FORCE(:,1)=1:21;
FORCE(:,4)=0.027*2*pi*100*1*(160/20)+0*(1:21);
FORCE(1,4)=0.5*FORCE(2,4);FORCE(21,4)=FORCE(1,4);
%座屈固有値は荷重倍数nである．
NPRESS=0;
PRESS=0*[TT 1];
