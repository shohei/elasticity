function [h,fl]=HENKA1(xi,xj,yi,yj,zi,zj)
h=zeros(12,12);
fl=sqrt((xj-xi)^2+(yj-yi)^2+(zj-zi)^2);
if xi ~= xj | yi ~= yj
  h(1,1)=(xj-xi)/fl;
  h(1,2)=(yj-yi)/fl;
  h(1,3)=(zj-zi)/fl;
  ff2=sqrt(h(1,2)^2+h(1,1)^2);
  h(2,1)=-h(1,2)/ff2;
  h(2,2)=h(1,1)/ff2;
  h(3,1)=-h(1,3)*h(2,2);
  h(3,2)=h(1,3)*h(2,1);
  h(3,3)=ff2;
else
  h(1,3)=1.0;
  h(2,1)=1.0;
  h(3,2)=1.0;
end
  for ni=1:3
    for nj=1:3
      i3=ni+3;
      j3=nj+3;
      i6=ni+6;
      j6=nj+6;
      i9=ni+9;
      j9=nj+9;
      h(i3,j3)=h(ni,nj);
      h(i6,j6)=h(ni,nj);
      h(i9,j9)=h(ni,nj);
    end
  end





