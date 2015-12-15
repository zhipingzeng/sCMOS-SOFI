%[sofi,fwhm]=sofiFlatten(fwhm,sofi,grid,orders)
%----------------------------------------------
%
%Flatten raw cumulants by the point spread function (PSF) full width at half-maximum.
%
%Inputs:
% fwhm      PSF diameter      {fit}
% sofi      Raw cumulants
% grid
%  .dists   Total distances
% orders    Cumulant orders   {all}
%
%Outputs:
% sofi      Flat cumulants
% fwhm      Applied PSF diameter

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
function [sofi,fwhm]=sofiFlatten(fwhm,sofi,grid,orders)
if nargin < 4
   orders=find(~cellfun(@isempty,sofi));
end
orders=orders(orders > 1);
if isempty(orders)
   return;
end
if isempty(fwhm)
   fwhm=sofiPSFfwhm(sofi,grid,orders);
end
sigma=4*log(2)./fwhm.^2;
if numel(sigma) == 1
   sigma=[sigma;sigma];
else
   sigma=sigma(:);
end
for order=orders(:).'
   img=sofi{order};
   [x,y,n]=size(img);
   term=exp(grid(order).dists.^2*sigma);
   term=reshape(term,order,order);
   term=repmat(term,ceil([x y]/order));
   sofi{order}=reshape(img(:,:,:).*term(1:x,1:y,ones(n,1)),size(img));
end
