function[IPLANE,E,PO,NELT,RR,TT,KOTEI,NFORCE,...
FORCE,NPRESS,PRESS]=DATAINPUT3
%有限要素法ハンドブック（下）p.429の例題
%  ++++++++++ data input ++++++++++++++++++
NFU=0;%軸対称荷重
E=7000;PO=0.3;%ヤング率とポアソン比
ALH=0;%線膨張係数
IPLANE=0;%0なら平面応力, 1なら平面ひずみ
NELT=11;%要素の数
NODT=NELT+1;%以下，半径方向の節点のr座標
RR=[50 55 62 70 80 90 105 120 140 160 180 200];
TT=0*(1:NELT)+1;%厚さ
%円周方向変位全部拘束KOTEI[節点番号　u v]
%u vに対応する数字は1なら拘束，0なら自由
KOTEI=[1 0 1;2 0 1;3 0 1;4 0 1;5 0 1;6 0 1;
 7 0 1;8 0 1;9 0 1;10 0 1;11 0 1;12 0 1];
%すべての節点のv変位を拘束した
NFORCE=1;%集中荷重あり
FORCE=[1 1*2*pi*50*1 0];%集中荷重,節点1のu方向
NPRESS=0;%分布荷重なし
PRESS=0*(1:NODT);%節点の分布荷重（NPRESS=0なので無視される）
