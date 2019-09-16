%--------------------------------------------------------------------------
% D:\Johannes\Matlab\fontchan.m:
% Routine to change fontsize and fonttype for labels, title, axislabels
%
% fontchan(nt,ny,nx,na)
%   nt: Fontsize for title
%   ny: Fontsize for ylabel
%   nx: Fontsize for xlabel
%   na: Fontsize for axis label
%   12/12/95                                           J. Gemmrich
%-------------------------------------------------------------------------

function fontchan(n1,n2,n3,n4,n5)
if length(n1) == 4
    n4 = n1(4); n3 = n1(3);n2 = n1(2); n1 = n1(1);
end
if nargin == 1
 nt = n1;  nx = n1; ny = n1; nz = n1; na = n1;
elseif nargin == 4
 nt = n1;  nx = n2; ny = n3; nz = n3; na = n4;
elseif nargin == 5
 nt = n1;  nx = n2; ny = n3; nz = n4; na = n5;
else
  nt = n1;  nx = n1; ny = n1; nz = n1; na = n1;
end


 set(get(gca,'xlabel'),'fontname','times','fontsize',nx)
 set(get(gca,'ylabel'),'fontname','times','fontsize',ny)
 set(get(gca,'title'),'fontname','times','fontsize',nt)
 set(gca,'fontname','times','fontsize',na)
 set(get(gca,'zlabel'),'fontname','times','fontsize',nz)