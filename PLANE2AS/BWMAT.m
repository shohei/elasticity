function[BM,FW]=BWMAT(S,AL,RP,NFU)
BM=zeros(3,4);
BM(1,1)=-1/AL;BM(1,3)=1/AL;
BM(2,1)=(1-S)/RP;BM(2,3)=S/RP;
BM(2,2)=NFU*(1-S)/RP;BM(2,4)=NFU*S/RP;
%if NFU >=1 
 BM(3,1)=-NFU*(1-S)/RP;BM(3,3)=-NFU*S/RP;
 BM(3,2)=-1/AL-(1-S)/RP;BM(3,4)=1/AL-S/RP;
%end
%
FW=(1:4)*0;
FW(1)=1-S;FW(3)=S;
