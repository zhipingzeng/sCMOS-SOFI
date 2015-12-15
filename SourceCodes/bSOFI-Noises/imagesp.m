%[fig,axe]=imagesp(img,tit)
%--------------------------
%
%Display an image with automatic (true-)color scaling.
%
%Inputs:
% img    Image
% tit    Title {Image}
%
%Outputs:
% fig    Figure handle
% axe    Axes handle

%Copyright © 2012 Marcel Leutenegger et al, École Polytechnique Fédérale de Lausanne,
%Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
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
function [fig,axe]=imagesp(img,tit)
if nargin < 2 || numel(tit) < 2
   tit='Image';
end
img=squeeze(img);
fig=findobj(get(0,'Children'),'flat','Name',tit);
if numel(fig)
   fig=fig(1);
   figure(fig);
   axe=get(fig,'Children');
else
   [m,n,k]=size(img);
   pos=get(0,'ScreenSize');
   pos=pos(3:4) - [m n+18];
   fig=figure('DoubleBuffer','on','Menubar','none','Name',tit,'NumberTitle','off','Colormap',gray(256),'Position',[pos/2 m n]);
   axe=axes('Parent',fig,'DataAspectRatio',[1 1 1],'Position',[0 0 1 1],'Visible','off','Nextplot','replacechildren','XLim',0.5+[0 m],'YLim',0.5+[0 n]);
end
if ~isreal(img)
   img=abs(img);
end
if k == 3 && ~isa(img,'uint8')
   for k=1:3
      j=img(:,:,k);
      m=min(j(isfinite(j)));
      n=max(j(isfinite(j)));
      img(:,:,k)=255.999/(n-m)*(j-m);
   end
   img=uint8(img);
end
imagesc(permute(img,[2 1 3]),'Parent',axe);
drawnow;
