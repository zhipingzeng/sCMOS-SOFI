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
Filepath0=cd;
cd('..');
InputFilepath=cd;
cd(Filepath0);
for index=1:16;
% matrix4=[20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 65 108 267];
matrix4=[20 40 60 80 100 120 140 160 180 200 220 240 260 65 108 267];
filepath=strcat(InputFilepath,'\RawData-PixelSize\',num2str(matrix4(index)),'\');

filepath_stack=strcat(filepath,'stack.tif');
stack=filepath_stack;

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
imwrite(img,strcat(filepath_stack,'_Balanced','.tif'));
for kk = 1:4
    temp = sofi{ kk};
    temp = ( temp - min( min( temp))) / (max( max( temp)) - min( min( temp)));
    imwrite( temp, [filepath_stack, num2str(kk),'.tif']);
end
filepath2=strcat(InputFilepath,'\conv_target\');
temp = sofi{ 3};
    temp = ( temp - min( min( temp))) / (max( max( temp)) - min( min( temp)));
    imwrite( temp, [filepath2, '3rd-',num2str(matrix4(index)),'.tif']);
    
end
