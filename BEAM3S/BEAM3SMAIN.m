function [HENI,TIKARA,FLOCAL,XX,YY,ZZ,KAKOM]=BEAM3SMAIN
% STATIC PROBLEM OF 3-DIMENSIONAL BEAM STRUCTURE
%        coded by K.Komatsu 1998/4/30
%            for MATLAB version 4.0
%
%  ++++++++++ data input ++++++++++++++++++
[NELT,NODT,KAKOM,KOTEI,XX,YY,ZZ,FORCEN...
   ,EA,EIY,EIZ,GJ]=DATAIN1;
%  ------- end (data input) -----------
 NT=NODT*6;
 TK=zeros(NT,NT);  
%
%  +++++++ element assembly +++++++++++++
for NE=1:NELT
   IN=KAKOM(NE,1);
     XI=XX(IN);YI=YY(IN);ZI=ZZ(IN);
   JN=KAKOM(NE,2);
     XJ=XX(JN);YJ=YY(JN);ZJ=ZZ(JN);
   [HEN,FL]=henka1(XI,XJ,YI,YJ,ZI,ZJ);
   [SK]=SKMAT(FL,EA(NE),EIZ(NE),EIY(NE),GJ(NE));
     SK=HEN' * SK * HEN;
   K1=((IN-1)*6)+(1:6);
   K2=((JN-1)*6)+(1:6);
  TK(K1,K1)=TK(K1,K1)+SK(1:6,1:6);
  TK(K1,K2)=TK(K1,K2)+SK(1:6,7:12);
  TK(K2,K2)=TK(K2,K2)+SK(7:12,7:12);
  TK(K2,K1)=TK(K2,K1)+SK(7:12,1:6);
end
% -------- end (assembly) --------------
TKK=TK;
%
% +++++++ boundary condition ++++++++++++
[TK,FNT,MM,KY]=PREREA(TK,FORCEN,NT,KOTEI);
% ------- end (boundary) ----------------
%
% ++++++++ solver ++++++++++++++++++++++++
HENI=TK\(FNT');
% -------- end (solve) ------------------
% ++++++++++ rearrangement ++++++++++++++
[HENI]=ARRMAT(HENI,NT,MM,KY);
TIKARA=TKK * HENI';
WD=zeros(12,1);
FLOCAL=zeros((2*NELT),8);
% ++++ stress resultant for each element ++
for NE=1:NELT
   IN=KAKOM(NE,1);
     XI=XX(IN);YI=YY(IN);ZI=ZZ(IN);
   JN=KAKOM(NE,2);
     XJ=XX(JN);YJ=YY(JN);ZJ=ZZ(JN);
   [HEN,FL]=henka1(XI,XJ,YI,YJ,ZI,ZJ);
   [SK]=SKMAT(FL,EA(NE),EIZ(NE),EIY(NE),GJ(NE));
 SK=HEN' *SK *HEN;
 IG=((IN-1)*6)+(1:6);
 JG=((JN-1)*6)+(1:6);
 WD(1:6)=HENI(IG);
 WD(7:12)=HENI(JG)';
 WS=HEN * SK * WD; 
 FLOCAL((NE*2-1),:)=[NE IN WS(1:6)'];
 FLOCAL((NE*2),:)=[NE JN WS(7:12)'];
end
% +++++++ print of the result ++++++++++
HENI=reshape(HENI,6,NODT);
HENI=HENI';
'displacement'
'node u v w bu bv bw'
[(1:NODT)' HENI]
TIKARA=reshape(TIKARA,6,NODT);
TIKARA=TIKARA';
'reaction force'
'node Fx Fy Fz Mx My Mz'
[(1:NODT)' TIKARA]
'local stress'
'element node Fx Fy Fz Mx My Mz'
FLOCAL
