function [TW]=RUNTEMP
%++++++++++データ入力++++++++++++++++++++++++
NELT=10;NFORCE=0;
NODT=NELT+1;NT=NODT;%１節点1自由度
RR=[5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];%節点座標
TT=1+0*(1:NELT);%厚さh
INDM=(2:10);INDS=[1 11];%境界条件
TEMP=[1 0;11 40];%温度条件
FNT=zeros(1,NT);%熱流速ベクトルの初期化
if NFORCE ~=0%集中荷重
  for IFN=1:NFORCE 
   IN=(FORCE(1,1)-1)*2+(1:2);
   FNT(IN)=FNT(IN)+FORCE(1,(2:3));
  end
 else
end
%  +++++++ element assembly +++++++++++++
TK=zeros(NT,NT);%全体剛性行列の初期化 
EM=[1 -1;-1 1];
for NE=1:NELT
R1=RR(NE);
AL=RR(NE+1)-R1;
SM=2*pi*TT(NE)*((AL*R1)*EM+(AL*AL*0.5)*EM);
   IJ=(NE-1)+(1:2);
  TK(IJ,IJ)=TK(IJ,IJ)+SM;%全体剛性行列への組み込み
%  FNT(IJ)=FNT(IJ)+FP'+FT';%分布荷重の外力ベクトルへの組み込み
end
% +++++++ boundary condition and solution ++++++++++++
TKMM=TK(INDM,INDM);TKMS=TK(INDM,INDS);
TKSM=TK(INDS,INDM);TKSS=TK(INDS,INDS);
FF=-TKMS*TEMP(:,2);
W=TKMM\FF;%連立一次方程式を解く
TW=zeros(2,NODT);IS=size(INDS);IM=size(INDM);
for I=1:IS(2)
TW(2,INDS(I))=TEMP(I,2);
end
for  I=1:IM(2)
TW(2,INDM(I))=W(I);
end
TW(1,:)=(1:NODT);
TW=TW';
