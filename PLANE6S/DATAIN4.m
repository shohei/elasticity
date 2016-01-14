function [XY,D,FORCE,KOTEI,KAKOM,T]=DATAIN4
IP=1;  % IP=1:plane stress, IP=2:plane strain
XY=[0 0; 0 2;1.414 1.414; 2 0;0 3.5;1.75 3.301
    3.301 1.75;3.5 0;0 5;1.913 4.619; 3.536  3.536
   4.619 1.913; 5 0];
KAKOM=[1 3 2;1 4 3;2 6 5;3 6 2;3 7 6
       4 7 3;4 8 7;5 10 9;6 10 5;6 11 10
      7 11 6;7 12 11; 8 12 7; 8 13 12];
KOTEI=[1 1 1;2 1 0;4 0 1; 5 1 0 
       8 0 1;9 1 0;13 0 1 ];
FORCE=[9 0 -500];
E=220000;PO=0.2;T=3;
% ---- end data input -----------
if IP == 1
  Peq=PO;Eeq=E/(1-PO*PO);P2=(1-PO)/2;
 else
  Peq=PO/(1-PO);P2=(1-2*PO)/2/(1-PO);
  Eeq=E*(1-PO)/(1+PO)/(1-2*PO);
end
D=Eeq*[1 Peq 0;Peq 1 0;0 0 P2];
