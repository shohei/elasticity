function[SM,FW,GM]=SWGMAT(NFU,AL,R1,R2,SN,CS,SIGMA,DM,TT,P1,P2,HEN)
%----Gauss integration formula ---------------------------
P=[0.9491079 0.7415312 0.4058452 0 -0.4058452 -0.7415312 -0.9491079];
H=[0.129485 0.2797054 0.3818301 0.4179592 0.3818301 0.2797054 0.129485];
% --------- end Gauss ------------------------------------
%
CN=0.5;
if NFU==0
  CN=1;
end
SM=zeros(8,8);%要素剛性行列の初期化
GM=zeros(8,8);%要素幾何剛性行列の初期化
FP=(1:8)*0;%要素分布荷重ベクトルの初期化
%--- begin numerical integration ---
for IT=1:7%ガウスの７点積分
S=0.5*(1+P(IT));%無次元化座標
RP=0.5*(R1+R2)+(P(IT)*AL*0.5*SN);%要素内任意点の半径
PP=P1+(P2-P1)*(P(IT)+1)*0.5;%分布圧力の内挿値
CONST=RP*AL*CN*H(IT)*3.1415926;%積分定数（円周方向）
CONSTP=3.1415926*RP*AL*CN*H(IT)*PP;%圧力の積分定数
%
[BM,FW,G]=BWGMAT(S,AL,RP,NFU,SN,CS);%歪-節点変位関係式
%
SM=SM + (BM' * DM * BM) * CONST;%数値積分の実行（足し合わせ）
GM=GM + (G' * SIGMA * G) * (CONST*TT);%数値積分の実行（足し合わせ）
FP=FP+FW*CONSTP;%数値積分の実行（足し合わせ）
end
%--- end numerical integration ---
SM= HEN' * SM *HEN;%要素剛性行列の全体座標系への変換
GM= HEN' * GM *HEN;%要素幾何剛性行列の全体座標系への変換
FW= FP*HEN;%圧力ベクトルの全体座標系への変換
