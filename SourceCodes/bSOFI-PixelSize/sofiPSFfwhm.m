%fwhm=sofiPSFfwhm(sofi,grid,orders)
%----------------------------------
%
%Estimate the point spread function (PSF) full width at half-maximum.
%
%Inputs:
% sofi      Raw cumulants
% grid
%  .dists   Total distances
% orders    Cumulant orders   {all}
%
%Output:
% fwhm      Estimated PSF diameter

%Copyright � 2012 Marcel Leutenegger et al, �cole Polytechnique F�d�rale de Lausanne,
%Laboratoire d'Optique Biom�dicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
function fwhm=sofiPSFfwhm(sofi,grid,orders)
if nargin < 3
   orders=find(~cellfun(@isempty,sofi));
end
orders=orders(orders > 1);
if isempty(orders)
   error('sofi:fwhm','Cannot estimate the PSF diameter: no image of cumulant order 2 or higher.');
end
%
% Estimate cumulant ratios within pixel groups.
%
ratios=[];
dists=sofi;
for order=orders(:).'
   avg=zeros(order);
   for x=1:order
      for y=1:order
         avg(x,y,:)=mean(mean(abs(sofi{order}(x:order:end,y:order:end,:)),1),2);
      end
   end
   x=x*y;
   y=size(avg,3);
   avg=reshape(avg,[x y]);
   avg=avg./repmat(mean(avg,1),x,1);
   ratios=[ratios;mean(avg,2)];
   dists{order}=sum(grid(order).dists.^2,2);
end
fwhm=lsqnonlin(@residuals,4,1,7,optimset('Display','off'),dists(orders),ratios);


%Residual differences of ratios.
%
% fwhm      FWHM of the PSF
% dists     Squared distances
% ratios    Estimated ratios
%
function resid=residuals(fwhm,dists,ratios)
resid=[];
waist=-4*log(2)/fwhm^2;
for n=1:numel(dists)
   ratio=exp(waist*dists{n});
   resid=[resid;ratio/mean(ratio)];
end
resid=resid - ratios;
