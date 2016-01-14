function [UV,STRESS]=PLANE6S
[XY,D,FORCE,KOTEI,KAKOM,T]=DATAIN4;
[NODT,DIM]=size(XY);
[NELT,KAKU]=size(KAKOM);
[NOFIX,JIYU]=size(KOTEI);
NT=NODT*(JIYU-1);
TK=zeros(NT,NT);
for NE=1:NELT
  K3=KAKOM(NE,1:3);
  X=XY(K3,1);Y=XY(K3,2);
  SM=STIFF(D,X,Y,T);
  TK=ASMAT(TK,SM,KAKOM,NE);
end
%
[TK,FNT,MM,KY]=PREREA(TK,FORCE,NT,KOTEI);
W=TK\(FNT');
W=ARRMAT(W,NT,MM,KY);
UV=reshape(W,2,NODT)
%
STRESS=zeros(NELT,6);
for NE=1:NELT
 K3=KAKOM(NE,1:3);
  X=XY(K3,1);Y=XY(K3,2);
IA=[K3(1)*2-1,K3(1)*2,K3(2)*2-1,K3(2)*2, K3(3)*2-1,K3(3)*2];
DS=W(IA);
[STR,HZM]=STRMAT(D,X,Y,T,DS);
STRESS(NE,:)=STR;
end
'OUTPUT UVWB :  u , v '
'OUTPUT STRESS : sig_r, sig_t, tau_rt sig_1 sig_2 theta'  
