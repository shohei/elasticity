function [VEC,RAMDA]=POWERD(A,NSYM,N,NEIG)
% N次の行列[A]の固有値と固有ベクトルを
%     大きいほうからNEIG個べき乗法により求める
% NSYM = 0 [A]が非対称行列(対称行列でも問題ない)
% NSYM = 1 [A]が対称行列に限る
VEC=zeros(N,NEIG);%固有ベクトルがVECに出力される
RAMDA=zeros(NEIG,1);%固有値がRAMDAに出力される
for NE=1:NEIG
RMM=0;X=2*(rand(N,1)-0.5);%初期ベクトル
 for I=1:100%最大100回の反復計算
   XK=A*X;
   [RMK,IM]=max(abs(XK));
   RM=XK(IM);
   X=XK/RM;
   E=abs((RMK-abs(RMM))/RMK);
  if E<=0.00002,break,end%固有値の精度設定
   RMM=RM;
 end
if I>=99
'eigen vector did not converge'
 else
end
if NSYM==1
    YK=XK;
 else
%左固有ベクトルの計算
 RNN=0;Y=2*(rand(N,1)-0.5);%初期ベクトル
 for I=1:100%最大100回の反復計算
   YK=(A')*Y;
   [RNK,IN]=max(abs(YK));
   RN=YK(IN);
   Y=YK/RN;
   E=abs((RNK-abs(RNN))/RNK);
  if E<=0.00002,break,end%固有値の精度設定
  RNN=RN; 
 end
end
ANORM=(YK')*XK;
YKS=YK/ANORM;
 VEC(1:N,NE)=XK/max(abs(XK));
 RAMDA(NE,1)=RM;  
 A=A-RM*(XK*YKS');%求められた固有ベクトルの除去
end