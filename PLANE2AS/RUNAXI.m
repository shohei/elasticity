function [UVWB,STRNODE,STRESS]=RUNAXI(NFU)
%++++++++++データ入力++++++++++++++++++++++++
[IPLANE,EYOUNG,PO,NELT,RR,TT,KOTEI,NFORCE,FORCE,NPRESS,PRESS]=DATAINPUT3;
% (...は継続行)
%+++++++++++ force vector +++++++++++++++++
NODT=NELT+1;NT=2*NODT;%１節点２自由度
FNT=zeros(1,NT);%外力ベクトルの初期化
if NFORCE ~=0%集中荷重がある場合，その数NFORCE
  for IFN=1:NFORCE 
   IN=(FORCE(1,1)-1)*2+(1:2);
   FNT(IN)=FNT(IN)+FORCE(1,(2:3));
  end
 else
end
%  +++++++ element assembly +++++++++++++
TK=zeros(NT,NT);%全体剛性行列の初期化 
for NE=1:NELT%要素行列の計算と重ね合わせ
%要素ごとのデータ
[DM,AL,R1,R2,TH,P1,P2]=NEDATA(NE,TT,EYOUNG,PO,RR,PRESS,IPLANE);
%要素の剛性行列の計算
[SM,FP]=SWMAT(NFU,AL,R1,R2,DM,PO,TH,P1,P2,IPLANE,NE);
%要素行列[SM]の全体行列[TK]への組み込み
   IJ=2*(NE-1)+(1:4);
  TK(IJ,IJ)=TK(IJ,IJ)+SM(1:4,1:4);%全体剛性行列への組み込み
%FNT:外力，FP:分布力
  FNT(IJ)=FNT(IJ)+FP;%分布荷重の外力ベクトルへの組み込み
end
% +++++++ boundary condition and solution ++++++++++++
[TK,FNT,MM,KY]=prerea1(TK,FNT,NT,KOTEI);%境界(拘束)条件の導入 
W=TK\(FNT');%連立一次方程式を解く
[W]=arrmat1(W,NT,MM,KY);%拘束条件の復帰 拘束条件自由度を0にして元に戻す
UVWB=reshape(W,2,NODT)';%変位ベクトルの整形 NODT×2 の表示の変位の計算結果
%+++++++++ stress and strain ++++++++++++++++++++++
STRNE=zeros(NELT,6);%要素の応力
STRNODE=zeros(NODT,3);%節点での応力
STRESS=zeros(NELT,3);%要素中央での応力
for NE=1:NELT%求められた変位から要素ごとにひずみと応力を計算
  [DM,AL,R1,R2,TH,P1,P2]=NEDATA(NE,TT,EYOUNG,PO,RR,PRESS,IPLANE);
  IA=(NE-1)*2+(1:4);
  DS=W(IA);
 [STR,HZM]=STRMAT(NFU,AL,R1,R2,DM,DS);
  STRNE(NE,:)=STR;
end
I3=1:3;
STRNODE(1,I3)=STRNE(1,I3);
for NE=2:NELT
 STRNODE(NE,I3)=0.5*(STRNE(NE,I3)+STRNE((NE-1),(3+I3)));
end
STRNODE(NODT,I3)=STRNE(NELT,(3+I3));
'OUTPUT UVWB :  u , v '
'OUTPUT STRESS : sig_r, sig_t, tau_rt'
for NE=1:NELT
STRESS(NE,I3)=0.5*(STRNODE(NE,I3)+STRNODE(NE+1,I3));
end
