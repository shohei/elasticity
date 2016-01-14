function [BUZAI,REACT3,DISP3,XX,YY,ZZ,KAKOM]=TRUSS3S
% STATIC PROBLEM OF 3-DIMENSIONAL TRUSS STRUCTURE
% XX,YY,ZZ 各要素のx,y,z座標
% KAKOM    各要素のつなぎ情報
% DISP3　　NODT×3 の節点変位
% REACT3　 NODT×3 の節点反力
% BUZAI　　NELT×2 の要素内部材力　BUZAI(NELT,2)が部材力
% データ入力は　INPUTn.m で
% 結果の図示は MODESH.m で
%
[XX,YY,ZZ,KAKOM,KOTEI,EAA,NFORCE,FORCE,NODT,NELT]=INPUT6;
%  ------- end (data input) -----------
NT=NODT*3;TK=zeros(NT,NT);FN=0*(1:NT);  
%  +++++++ element assembly +++++++++++++
for NE=1:NELT
   EA=EAA(NE);
   IN=KAKOM(NE,1);JN=KAKOM(NE,2);
HEN=zeros(2,6);
FL=sqrt((XX(JN)-XX(IN))^2+(YY(JN)-YY(IN))^2+(ZZ(JN)-ZZ(IN))^2);
  HEN(1,1)=(XX(JN)-XX(IN))/FL;HEN(1,2)=(YY(JN)-YY(IN))/FL;
  HEN(1,3)=(ZZ(JN)-ZZ(IN))/FL;HEN(2,4)=(XX(JN)-XX(IN))/FL;
  HEN(2,5)=(YY(JN)-YY(IN))/FL;HEN(2,6)=(ZZ(JN)-ZZ(IN))/FL;
 CK=zeros(2,2);EAL=EA/FL;
     CK(1,1)=EAL;CK(1,2)=-EAL;
     CK(2,1)=-EAL;CK(2,2)=EAL; 
     CK=HEN' * CK * HEN;
   K1=((KAKOM(NE,1)-1)*3)+(1:3);
   K2=((KAKOM(NE,2)-1)*3)+(1:3);
  TK(K1,K1)=TK(K1,K1)+CK(1:3,1:3);
  TK(K1,K2)=TK(K1,K2)+CK(1:3,4:6);
  TK(K2,K2)=TK(K2,K2)+CK(4:6,4:6);
  TK(K2,K1)=TK(K2,K1)+CK(4:6,1:3);
end
for I=1:NFORCE
 IN=(FORCE(I,1)-1)*3+(1:3);
 FN(IN)=FN(IN)+FORCE(I,(2:4));
end
% (assembly) --------------
% +++++++ boundary condition +++++++
[TK1,TK2,TK3,FN1,MM,IM,IS]=PREREA3(TK,FN,NT,KOTEI);
% ++++++++ solver ++++++++++++++++++++++++
DEL=TK1\(FN1');
DISP=0*(1:NT);NN=NT-MM;
DISP(IS)=0*(1:NN);DISP(IM)=DEL;
DISP3=reshape(DISP,3,NODT)';
FINT=TK2*DEL;
REACTF=0*(1:NT);REACT(IM)=FN(IM);
REACT(IS)=FINT;REACT3=reshape(REACT,3,NODT)';
%
%-----member force ------------------------
BUZAI=zeros(NELT,2);
for NE=1:NELT%各要素ごとに部材力の計算
   IN=KAKOM(NE,1);JN=KAKOM(NE,2);
HEN=zeros(2,6);
FL=sqrt((XX(JN)-XX(IN))^2+(YY(JN)-YY(IN))^2+(ZZ(JN)-ZZ(IN))^2);
  HEN(1,1)=(XX(JN)-XX(IN))/FL;HEN(1,2)=(YY(JN)-YY(IN))/FL;
  HEN(1,3)=(ZZ(JN)-ZZ(IN))/FL;HEN(2,4)=(XX(JN)-XX(IN))/FL;
  HEN(2,5)=(YY(JN)-YY(IN))/FL;HEN(2,6)=(ZZ(JN)-ZZ(IN))/FL;
 CK=zeros(2,2);EAL=EA/FL;
     CK(1,1)=EAL;CK(1,2)=-EAL;
     CK(2,1)=-EAL;CK(2,2)=EAL; 
     CK=HEN' * CK * HEN;%要素剛性行列の全体座標系への変換
IN3=(IN-1)*3+(1:3);JN3=(JN-1)*3+(1:3);
BUZAI(NE,:)=HEN*CK*(DISP([IN3 JN3])');%全体変位から部材力を計算
%さらに部材座標系に戻す．BUZAI(NE,2)が部材力，＋が引張，－が圧縮
end
