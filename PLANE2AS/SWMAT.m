function [SM,FP]=SWMAT(NFU,AL,R1,R2,DM,PO,TH,P1,P2,IPLANE,NE)
%----Gauss integration formula ---------------------------
P=[0.9491079 0.7415312 0.4058452 0 -0.4058452 -0.7415312 -0.9491079];
H=[0.129485 0.2797054 0.3818301 0.4179592 0.3818301 0.2797054 0.129485];
% --------- end Gauss ------------------------------------
%
SM=zeros(4,4);
FP=(1:4)*0;
%--- begin numerical integration ---
for IT=1:7
S=0.5*(1+P(IT));
RP=0.5*(R1+R2)+(P(IT)*AL*0.5);
PP=P1+(P2-P1)*(P(IT)+1)*0.5;
CONST=RP*AL*H(IT)*3.1415926*0.5;
CONSTP=RP*AL*H(IT)*3.1415926*0.5*PP;
%
[BM,FW]=BWMAT(S,AL,RP,NFU);
%
BD=BM'*DM;
SM=SM + (BD * BM) * (CONST*TH);
FP=FP+FW*(CONSTP*TH);%分布力
end
%--- end numerical integration ---
if NFU ==0
 SM=2*SM;
 FP=2*FP;
end
