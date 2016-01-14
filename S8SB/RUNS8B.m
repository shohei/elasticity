function [STRESS]=RUNS8B(NFI,NFE)
%  ++++++++++ data input ++++++++++++++++++
[EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,NFORCE,FORCE,NPRESS,PRESS]=DATAIN2B;
NT=4*NODT;%全自由度
FNT=zeros(1,NT);%外力ベクトル
if NFORCE ~=0
  for IFN=1:NFORCE 
   IN=(FORCE(IFN,1)-1)*4+(1:4);
   FNT(IN)=FNT(IN)+FORCE(IFN,(2:5));
  end
 else
end
%
 TK=zeros(NT,NT);%全体剛性行列の初期化 
%
NFU=0;%座屈前は軸対称変形
SIGMA=zeros(3,3);
%  +++++++ element assembly +++++++++++++
for NE=1:NELT
[DM,AL,R1,R2,SN,CS,TH,P1,P2,HEN]=NEDATA(NE,TT,EYOUNG,PO,RR,ZZ,PRESS);
[SM,FW,GM]=SWGMAT(NFU,AL,R1,R2,SN,CS,SIGMA,DM,TH,P1,P2,HEN);
   IJ=4*(NE-1)+(1:8);
  TK(IJ,IJ)=TK(IJ,IJ)+SM;
  FNT(IJ)=FNT(IJ)+FW;
end
%
% +++++++ boundary condition ++++++++++++
[TKM,FNTM,MM,KY]=PREREA1(TK,FNT,NT,KOTEI);
W=TKM\(FNTM');
[W]=ARRMAT1(W,NT,MM,KY);
UVWB=reshape(W,4,NODT)';
%
STRNE=zeros(NELT,12);
STRESS=zeros(NODT,6);
%
for NE=1:NELT
[DM,AL,R1,R2,SN,CS,TH,P1,P2,HEN]=NEDATA(NE,TT,EYOUNG,PO,RR,ZZ,PRESS);
%
IA=(NE-1)*4+(1:8);
DS=W(IA);
[STR,HZM]=STRMAT(NFU,AL,R1,R2,SN,CS,DM,TT,HEN,DS);
STRNE(NE,:)=STR';%ここでの応力とは合応力のことである
end
I6=1:6;
STRESS(1,I6)=STRNE(1,I6);
for NE=2:NELT
 STRESS(NE,I6)=0.5*(STRNE(NE,I6)+STRNE((NE-1),(6+I6)));
end
STRESS(NODT,I6)=STRNE(NELT,(6+I6));
'OUTPUT UVWB :  u , v ,w , dw/ds'
'OUTPUT STRESS : Ns, Nt, Nst, Ms, Mt, Mst'  
for NFU=NFI:NFE
%  +++++++ element assembly +++++++++++++
TK=zeros(NT,NT);TG=zeros(NT,NT);
for NE=1:NELT
SIGS=(STRESS(NE,1)+STRESS(NE+1,1))*0.5/TT(NE);
SIGT=(STRESS(NE,2)+STRESS(NE+1,2))*0.5/TT(NE);
SIGMA=[SIGS 0 0;0 SIGT 0;0 0 (SIGS+SIGT)];
 if NFU==0 
  SIGMA(3,3)=0;
 end
[DM,AL,R1,R2,SN,CS,TH,P1,P2,HEN]=NEDATA(NE,TT,EYOUNG,PO,RR,ZZ,PRESS);
[SM,FW,GM]=SWGMAT(NFU,AL,R1,R2,SN,CS,SIGMA,DM,TH,P1,P2,HEN);
   IJ=4*(NE-1)+(1:8);
  TG(IJ,IJ)=TG(IJ,IJ)+GM;
  TK(IJ,IJ)=TK(IJ,IJ)+SM;
end
%
[TKM,FNTG,MM,KY]=PREREA1(TK,FNT,NT,KOTEI);
[TGM,FNTG,MM,KY]=PREREA1(TG,FNT,NT,KOTEI);
AMAT=inv(TKM)*TGM;NEIG=1;
[VEC,RAMDA]=POWERD(AMAT,0,MM,NEIG);
%[VEC,RAMDA,ITE]=SUBSPA(TKM,TGM,MM,NEIG);
[W]=ARRMAT1(VEC,NT,MM,KY);
UVWB=reshape(W,4,NODT)';
NFU
Pcr=-1/RAMDA
UVWB
end
