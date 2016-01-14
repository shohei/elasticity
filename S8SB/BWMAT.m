function[BM,FW]=BWMAT(S,AL,RP,NFU,SN,CS)
%要素の歪-節点変位関係式{e}=[BM]{delta}
S2=S*S;S3=S2*S;AL2=AL*AL;
B1=1-S;B2=S;B3=-1/AL;B4=1/AL;
C1=1-3*S2+2*S3;
C2=AL*(S-2*S2+S3);
C3=3*S2-2*S3;
C4=AL*(-S2+S3);
C5=6*(-S+S2)/AL;
C6=1-4*S+3*S2;
C7=-C5;
C8=-2*S+3*S2;
D1=(-6+12*S)/AL2;
D2=(-4+6*S)/AL;
D3=(6-12*S)/AL2;
D4=(-2+6*S)/AL;
%
SS=SN/RP;CC=CS/RP;FF=NFU/RP;
BM=zeros(6,8);
BM(1,1)=B3;BM(1,5)=B4;
BM(2,1:8)=[SS*B1 FF*B1 CC*C1 CC*C2 SS*B2 FF*B2 CC*C3 CC*C4];
BM(3,1:8)=[-FF*B1 (B3-SS*B1) 0 0 -FF*B2 (B4-SS*B2) 0 0];
BM(4,1:8)=[0 0 -D1 -D2 0 0 -D3 -D4];
BM(5,2)=FF*CC*B1;BM(5,3)=C1*FF*FF-SS*C5;BM(5,4)=C2*FF*FF-SS*C6;
BM(5,6)=FF*CC*B2;BM(5,7)=C3*FF*FF-SS*C7;BM(5,8)=C4*FF*FF-SS*C8;
BM(6,2)=CC*B3-SS*CC*B1;BM(6,3)=FF*C5-FF*SS*C1;BM(6,4)=FF*C6-FF*SS*C2;
BM(6,6)=CC*B4-SS*CC*B2;BM(6,7)=FF*C7-FF*SS*C3;BM(6,8)=FF*C8-FF*SS*C4;
BM(6,1:8)=2*BM(6,1:8);
%
%圧力の内挿（要素座標系では変位wの方向に作用）
FW=(1:8)*0;
FW(3)=C1;FW(4)=C2;FW(7)=C3;FW(8)=C4;
