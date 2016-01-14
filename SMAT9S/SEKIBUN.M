function [SEKI]=SEKIBUN(CS,SN,IVIP)
W=[1  0  0  0  0  0
   0 CS SN  0  0  0
   0 -SN CS 0  0  0
   0  0  0  1  0  0 
   0  0  0  0  CS SN
   0  0  0  0 -SN CS];
A=0;B=0;C=0;
if (IVIP == 1)
  A=1;
  else
   if(IVIP == 2)
    B=1;
    else
     C=1;
    end
  end
ABC=[A 0 0 B 0 0 C 0 0
     0 A 0 0 B 0 0 C 0
     0 0 A 0 0 B 0 0 C
     C 0 0 A 0 0 B 0 0
     0 C 0 0 A 0 0 B 0
     0 0 C 0 0 A 0 0 B];
SEKI=W * ABC;
