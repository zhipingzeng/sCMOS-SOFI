%--------------------------------------------------------------------------
% Source code for generating stacks of blinking frames of rotating target with different frame rates
% Copyright 2015 Zhiping Zeng
%--------------------------------------------------------------------------

%% Read target file

close all;
clc
InputFilepath=cd;
pixelnumber=672;
aa=zeros(pixelnumber);
targetForSCMOSAndEMCCD=imread('target for sCMOS and EMCCD.tif');
[row, col] = find( targetForSCMOSAndEMCCD > 40 );   
num = size(row, 1);            
bb=aa;
for i = 1:2:num                
    bb(row(i), col(i)) = 1;     
end
imshow(bb,[])

%% Generate power law blinking

n1=10;   %sCMOS
% n1=5*10/3; %EMCCD
n2=0;
C = zeros(1.5*num,2*1000);
for n=1:2:1.5*num               
alpha=1.5;
alpha_off=1.9;
dmax=1;
frame_time=0.03; % s
xx=rand(1,1000);
ton1 = 0.01*exp(log(dmax)-log(xx)./alpha);  %on time power law
frame_on1 = ceil(ton1/frame_time);

xx=rand(1,1000);
toff1 = 0.01*exp(log(dmax)-log(xx)./alpha_off);   %off time power law
frame_off1 = 2*ceil(toff1/frame_time);
C(n,1:2:end) = frame_on1;
C(n,2:2:end) = frame_off1;
end  

%% Image rotation

a=ones(1,1.5*num);
for frame=1:150
aa=zeros(pixelnumber);
angle=frame/100; %sCMOS
% angle=10*frame/100/3; %EMCCD
J = imrotate(targetForSCMOSAndEMCCD,angle,'bilinear','crop');             %image rotation
[row, col] = find( J > 40 );   %image rotation occurs in every frame
num = size(row, 1);       
    for m=1:2:num
    if C(m,a(m))>0
       aa(row(m), col(m))  = n1*exp(-0.002*frame);  %photobleach,EMCCD*10/3
        C(m,a(m))=C(m,a(m))-1;
    else aa(row(m), col(m))  = n2*exp(-0.002*frame);
        a(m)=a(m)+1;
        temp1=n1;
        n1=n2;
        n2=temp1;        
    end
    end
% Generate the PSF.
xx=-1:0.02:1; %pixel size 20nm
PSFX=gaussmf(xx,[0.095 0]);   %fwhm=223.8nm for 0.095
PSFXY=PSFX'*PSFX; 
jj=conv2(aa,PSFXY);
jj65=imresize(jj,20/65);  %resize pixel size to 65nm
% Add shot noise.
len=length(jj65);
shotnoise=zeros(len,len);
shotnoise_sigma=sqrt(jj65);   
for x=1:len
     for y=1:len
         shotnoise(x,y)=poissrnd(shotnoise_sigma(x,y));
     end
 end
jj65=jj65+shotnoise;
figure(2)
imshow(jj65,[]);pause(0.01)
filepath2=strcat(InputFilepath,'\RawData-FrameRate\');
mkdir(filepath2);
imwrite(uint16(jj65),[filepath2 int2str(frame) '.tif']);
end

