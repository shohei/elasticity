function[XX,YY,ZZ,KAKOM,KOTEI,EAA,NFORCE,FORCE,NODT,NELT]=INPUT6
% 例題：Martin p.50
%  ++++++++++ data input ++++++++++++++++++
 NELT=9;NODT=6;%要素数と節点数
XX=[0 2.5 1.25 0.75 1.75 1.25];%節点のx座標
YY=[0 0 2 0.4 0.4 1.2];%節点のy座標
ZZ=[0 0 0 2 2 2];%節点のz座標
KAKOM=[1 4;1 6;2 4;2 5;3 5;3 6;4 5;4 6;5 6];%要素のつなぎ
EAA=8E7+0*(1:NELT);%各要素のEA
  KOTEI=[1 1 1 1;2 1 1 1;3 1 1 1];%節点1,2,3のx,y,z方向を拘束
NFORCE=1;%荷重点はひとつ
  FORCE=[5 100 0 -100];%節点5でFX=100,FZ=-100を負荷
