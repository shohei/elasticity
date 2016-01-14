function [EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,...
NFORCE,FORCE,NPRESS,PRESS]=DATAIN5S
%(注意)...は継続行をあらわす
%
%ミラーの例題（縦置き，PRESSで入力）
%
EYOUNG=7000000;PO=0.3;
NODT=11;NELT=10;
A11=(pi/6)*0.1*((1:11)-1);%部分球の角度の分割
RR=300*sin(A11);%半径
RR(1)=0.1;%応力計算の特異性を除くための処置
ZZ=300*(1-cos(A11));%z座標
TT=[2 2 2 2 2 2 2 2 2 2];%各要素の厚さ
KOTEI=[1 1 1 1 1
       2 1 1 1 1];%節点1と2を固定
NFORCE=9;%分布荷重を９個の集中荷重に置き換える
FFF=RR*2*pi*2.7*0.001*980*2;
FFP=0*(1:NODT);FFPAV=FFP;%その集中荷重を２節点に振り分け
for I=2:NELT
FFP(I)=FFF(I)*sqrt((RR(I)-RR(I-1))^2+(ZZ(I)-ZZ(I-1))^2);%Cの計算
end
  FFPAV(2)=FFP(1)*0.5;
 for I=3:NODT
  FFPAV(I)=0.5*(FFP(I-1)+FFP(I));
 end
  FFPAV(NODT)=0.5*FFP(NODT-1);
FORCE=zeros(8,4);%荷重節点,NU,NV,NWの順に荷重を入れる
 for I=1:(NODT-2)
  FORCE(I,:)=[I+2 0 -FFPAV(I+2) FFPAV(I+2)];
 end     
NPRESS=0;%分布荷重は考えないので次行は無視
PRESS=0*2.7*0.001*980*[TT 2];
