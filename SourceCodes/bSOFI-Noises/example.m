%Example of the SOFI analysis of an image sequence.

%Copyright ?2012 Marcel Leutenegger et al, École Polytechnique Fédérale de Lausanne,
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

%% Image TIFF file or image sequence.
%
clear all
clc
close all
InputFilepath=cd;
for index=1:20;
    for f=1:2;
matrix4=[3 10 20 50 80 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500];
% filepath2=strcat('G:\ZZP-HP Pro\D\comparison of sCMOS and EMCCD\data\·Ö±æÂÊ°å\raw data\20150320\shot_fixed_read_noise-20151006\raw_data\raw_data\','photon-',num2str(matrix4(index)),'\without noise\');
filepath3=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\sCMOS\');
filepath4=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\EMCCD\');
% matrix5={filepath2 filepath3 filepath4};
matrix5={filepath3 filepath4};
filepath=matrix5(f);
filepath_stack=strcat(filepath,'stack.tif');
stack=filepath_stack{1};

%% Analyze the image sequence.
%
[sofi,grid]=sofiCumulants(stack);
[sofi,fwhm]=sofiFlatten([],sofi,grid);
[ratio,density,brightness]=sofiParameters(sofi);   % need flat cumulants to get parameters
sofi=sofiLinearize(sofi,fwhm);                     % "blind" linearization (no parameters)
img=sofiBalance(sofi,ratio);                       % use 3rd order in minima of 4th order

%% Display the results.
%
% for n=1:4
%    imagesp(sofi{n},sprintf('%d. order',n));
% %    imwrite(sofi{n},strcat('D:\',int2str(n),'.tif'),'BitDepth',16);
% end
% imagesp(img,'Balanced');
% img4=imadjust(img);
% imshow(img);
% temp=getframe;
imwrite(img,strcat(filepath{1},'_Balanced','.tif'));
for kk = 1:4
    temp = sofi{ kk};
    temp = ( temp - min( min( temp))) / (max( max( temp)) - min( min( temp)));
    imwrite( temp, [filepath{1}, num2str(kk),'.tif']);
end
    end
end
