function [XY,D,FORCE,KOTEI,KAKOM,T]=DATAIN3
%example:FEMhandbook,Vol.2,p.430
IP=1;  % IP=1:plane stress, IP=2:plane strain
NELT=64;NODT=45;
XY=zeros(NODT,2);
XY(1:9,1)=[0 125 250 375 500 625 750 875 1000];
XY(10:18,1)=XY(1:9,1);XY(19:27,1)=XY(1:9,1);
XY(28:36,1)=XY(1:9,1);XY(37:45,1)=XY(1:9,1);
XY(1:9,2)=0*(1:9);XY(10:18,2)=0*(1:9)+50;
XY(19:27,2)=0*(1:9)+100;XY(28:36,2)=0*(1:9)+150;
XY(37:45,2)=0*(1:9)+200;
KAKOM=zeros(64,3);
KAKOM(1,:)=[1 2 10];KAKOM(2,:)=[2 11 10];
for IG=1:4
  IP=(IG-1)*9;
  IE=(IG-1)*16;
 for NE=1:8
  N1=2*NE-1+IE;
  N2=2*NE+IE;
  KAKOM(N1,:)=[1 2 10]+(NE-1)+IP;
  KAKOM(N2,:)=[2 11 10]+(NE-1)+IP;
 end
end
KOTEI=[9 1 1;18 1 1; 27 1 1;36 1 1;45 1 1];
FORCE=[1 0 0.2;10 0 0.2;19 0 0.2;28 0 0.2;37 0 0.2];
E=7000;PO=0.3;T=1;
% ---- end data input -----------
if IP == 1
  Peq=PO;Eeq=E/(1-PO*PO);P2=(1-PO)/2;
 else
  Peq=PO/(1-PO);P2=(1-2*PO)/2/(1-PO);
  Eeq=E*(1-PO)/(1+PO)/(1-2*PO);
end
D=Eeq*[1 Peq 0;Peq 1 0;0 0 P2];