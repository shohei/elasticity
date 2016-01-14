function [UVWB,STRESS]=RUNS8S(NFU)
%
%  ++++++++++ data input ++++++++++++++++++
[EYOUNG,PO,NODT,NELT,RR,ZZ,TT,KOTEI,NFORCE,...
FORCE,NPRESS,PRESS]=DATAIN5S
% ...は継続行を示す
%+++++++++++ end data +++++++++++++++++
NT=4*NODT;
FNT=zeros(1,NT);
if NFORCE ~=0
  for IFN=1:NFORCE 
   IN=(FORCE(1,1)-1)*4+(1:3);
   FNT(IN)=FNT(IN)+FORCE(1,(2:4));
  end
 else
end
%
 TK=zeros(NT,NT); 
%

%  +++++++ element assembly +++++++++++++
for NE=1:NELT
[DM,AL,R1,R2,SN,CS,TH,P1,P2,HEN]...
=NEDATA(NE,TT,EYOUNG,PO,RR,ZZ,PRESS);
[SM,FW]=SWMAT(NFU,AL,R1,R2,SN,CS,DM,TH,P1,P2,HEN);
   IJ=4*(NE-1)+(1:8);
  TK(IJ,IJ)=TK(IJ,IJ)+SM(1:8,1:8);
  FNT(IJ)=FNT(IJ)+FW;
end
%
% +++++++ boundary condition ++++++++++++
[TK,FNT,MM,KY]=prerea1(TK,FNT,NT,KOTEI);
W=TK\(FNT');
[W]=arrmat1(W,NT,MM,KY);
UVWB=reshape(W,4,NODT)';
%
STRNE=zeros(NELT,12);
STRESS=zeros(NODT,6);
%
for NE=1:NELT
[DM,AL,R1,R2,SN,CS,TH,P1,P2,HEN]...
=NEDATA(NE,TT,EYOUNG,PO,RR,ZZ,PRESS);
%
IA=(NE-1)*4+(1:8);
DS=W(IA);
[STR,HZM]=STRMAT(NFU,AL,R1,R2,SN,CS,DM,TT,HEN,DS);
STRNE(NE,:)=STR;
end
STR
I6=1:6;
STRESS(1,I6)=STRNE(1,I6);
for NE=2:NELT
 STRESS(NE,I6)=0.5*(STRNE(NE,I6)+STRNE((NE-1),(6+I6)));
end
STRESS(NODT,I6)=STRNE(NELT,(6+I6));
'OUTPUT UVWB :  u , v ,w , dw/ds'
'OUTPUT STRESS : Ns, Nt, Nst, Ms, Mt, Mst'  
