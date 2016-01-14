function [EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,...
NFORCE,FORCE,NPRESS,PRESS]=DATAIN1B
%(注意)...は継続行をあらわす
%両端単純支持の円筒シェルの軸圧縮座屈
EYOUNG=7000;PO=0.3;%ヤング率とポアソン比
NODT=21;NELT=20;%節点と要素数
RR=100+0*(1:NODT);%シェルの半径
ZZ=(160/NELT)*((1:NODT)-1);%シェルの高さ
TT=1+0*(1:NELT);%シェルの厚さ
KOTEI=[1 0 0 1 0;11 1 0 0 0;21 0 0 1 0];
%両端(節点１と11)のwを拘束（単純支持）中央点のuを拘束
NFORCE=2;%両側から集中荷重
FORCE=[1 1 0 0 0;21 -1 0 0 0];%荷重の値（単位値）
NPRESS=0;%分布圧力なし
PRESS=0*0.001*980*[TT 2];%(適当な数値を入れておく)
