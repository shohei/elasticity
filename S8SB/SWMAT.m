function[SM,FW]=SWMAT(NFU,AL,R1,R2,SN,CS,DM,TT,P1,P2,HEN)
%----Gauss integration formula ---------------------------
P=[0.9491079 0.7415312 0.4058452 0 -0.4058452 -0.7415312 -0.9491079];
H=[0.129485 0.2797054 0.3818301 0.4179592 0.3818301 0.2797054 0.129485];
% --------- end Gauss ------------------------------------
%
SM=zeros(8,8);
QM=zeros(8,8);
FP=(1:8)*0;
%--- begin numerical integration ---
for IT=1:7
S=0.5*(1+P(IT));
RP=0.5*(R1+R2)+(P(IT)*AL*0.5*SN);
PP=P1+(P2-P1)*(P(IT)+1)*0.5;
CONST=RP*AL*0.5*H(IT)*3.1415926;
CONSTP=3.1415926*RP*AL*0.5*H(IT)*PP;
%
[BM,FW]=BWMAT(S,AL,RP,NFU,SN,CS);
%
SM=SM + (BM' * DM * BM) * CONST;
FP=FP+FW*CONSTP;
end
%--- end numerical integration ---
%
SM= HEN' * SM *HEN;
FW= FP*HEN;
