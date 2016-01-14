function[IPLANE,EYOUNG,PO,NELT,RR,TT,KOTEI, ...(継続行)
NFORCE,FORCE,NPRESS,PRESS]=DATAINPUT2
%Timoshenkoの例題(Theory of Elasticity, p.82)
%  ++++++++++ data input ++++++++++++++++++
EYOUNG=2E11;PO=0.3;RHO=2.7;OMEGA=2*pi;ALH=0;
IPLANE=0;%0なら平面応力, 1なら平面ひずみ
NODT=14;NELT=13;
RR=[0.2 0.21 0.22 0.24 0.27 0.3 0.35 0.4 0.5 0.6 0.7 0.8 0.9 1.0];%半径
TT=0*(1:13)+0.05;%板厚
KOTEI=zeros(NODT,3);%拘束条件行列の初期化
for I=1:NODT
KOTEI(I,:)=[I 0 1];%円周方向固定
end
NFORCE=0;%集中荷重なし
FORCE=[5 500 0];%NFORCE=0なので無視される
NPRESS=1;%分布荷重あり
PRESS=zeros(NODT,2);
PRESS(:,1)=RHO*OMEGA^2*RR;%遠心力
