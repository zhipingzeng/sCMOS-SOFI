%--------------------------------------------------------------------------
% Source code for generating stacks of blinking frames with different noises included
% Copyright 2015 Zhiping Zeng
%--------------------------------------------------------------------------

%% Read resolution target file

close all;clear all;
clc
InputFilepath=cd;
pixelnumber=452;
aa3=zeros(pixelnumber);
aa10=zeros(pixelnumber);
aa20=zeros(pixelnumber);
aa50=zeros(pixelnumber);
aa80=zeros(pixelnumber);
aa100=zeros(pixelnumber);
aa200=zeros(pixelnumber);
aa300=zeros(pixelnumber);
aa400=zeros(pixelnumber);
aa500=zeros(pixelnumber);
aa600=zeros(pixelnumber);
aa700=zeros(pixelnumber);
aa800=zeros(pixelnumber);
aa900=zeros(pixelnumber);
aa1000=zeros(pixelnumber);
aa1100=zeros(pixelnumber);
aa1200=zeros(pixelnumber);
aa1300=zeros(pixelnumber);
aa1400=zeros(pixelnumber);
aa1500=zeros(pixelnumber);
aa=zeros(pixelnumber);
test_object=imread('resolution_target_3_dig.tif');  %load test object
[row, col] = find( test_object >100 );   
num = size(row, 1);            
bb=aa;
counter=0;
for i = 1:2:num                
    bb(row(i), col(i)) = 1;     
    counter=counter+1;
end
imshow(bb,[])

%% Generate power law blinking

n1_3=3;
n1_10=10;
n1_20=20;
n1_50=50;
n1_80=80;
n1_100=100;
n1_200=200;
n1_300=300;
n1_400=400;
n1_500=500;
n1_600=600;
n1_700=700;
n1_800=800;
n1_900=900;
n1_1000=1000;
n1_1100=1100;
n1_1200=1200;
n1_1300=1300;
n1_1400=1400;
n1_1500=1500;
n2_3=0;
n2_10=0;
n2_20=0;
n2_50=0;
n2_80=0;
n2_100=0;
n2_200=0;
n2_300=0;
n2_400=0;
n2_500=0;
n2_600=0;
n2_700=0;
n2_800=0;
n2_900=0;
n2_1000=0;
n2_1100=0;
n2_1200=0;
n2_1300=0;
n2_1400=0;
n2_1500=0;
C = zeros(num,2*1000);
for n=1:2:num              
alpha=1.5;
alpha_off=1.9;
dmax=1;
frame_time=0.03; % s
xx=rand(1,1000);
ton1 = 0.01*exp(log(dmax)-log(xx)./alpha);   %on time power law
frame_on1 = ceil(ton1/frame_time);
xx=rand(1,1000);
toff1 = 0.01*exp(log(dmax)-log(xx)./alpha_off);  %off time power law
frame_off1 = 2*ceil(toff1/frame_time);
C(n,1:2:end) = frame_on1;
C(n,2:2:end) = frame_off1;
end  
a=ones(1,num);
for frame=1:150
for m=1:2:num
    if C(m,a(m))>0
       aa3(row(m), col(m))=n1_3;  
       aa10(row(m), col(m))=n1_10;  
       aa20(row(m), col(m))=n1_20;  
       aa50(row(m), col(m))=n1_50;  
       aa80(row(m), col(m))=n1_80;  
       aa100(row(m), col(m))=n1_100;  
       aa200(row(m), col(m))=n1_200;  
       aa300(row(m), col(m))=n1_300;  
       aa400(row(m), col(m))=n1_400;  
       aa500(row(m), col(m))=n1_500;  
       aa600(row(m), col(m))=n1_600;  
       aa700(row(m), col(m))=n1_700;  
       aa800(row(m), col(m))=n1_800;  
       aa900(row(m), col(m))=n1_900;  
       aa1000(row(m), col(m))=n1_1000;  
       aa1100(row(m), col(m))=n1_1100;  
       aa1200(row(m), col(m))=n1_1200;  
       aa1300(row(m), col(m))=n1_1300;  
       aa1400(row(m), col(m))=n1_1400;  
       aa1500(row(m), col(m))=n1_1500;  
       C(m,a(m))=C(m,a(m))-1;
    else
       aa3(row(m), col(m))=n2_3;  
       aa10(row(m), col(m))=n2_10;  
       aa20(row(m), col(m))=n2_20;  
       aa50(row(m), col(m))=n2_50;  
       aa80(row(m), col(m))=n2_80;  
       aa100(row(m), col(m))=n2_100;  
       aa200(row(m), col(m))=n2_200;  
       aa300(row(m), col(m))=n2_300;  
       aa400(row(m), col(m))=n2_400;  
       aa500(row(m), col(m))=n2_500;  
       aa600(row(m), col(m))=n2_600;  
       aa700(row(m), col(m))=n2_700;  
       aa800(row(m), col(m))=n2_800;  
       aa900(row(m), col(m))=n2_900;  
       aa1000(row(m), col(m))=n2_1000;  
       aa1100(row(m), col(m))=n2_1100;  
       aa1200(row(m), col(m))=n2_1200;  
       aa1300(row(m), col(m))=n2_1300;  
       aa1400(row(m), col(m))=n2_1400;  
       aa1500(row(m), col(m))=n2_1500;  
       a(m)=a(m)+1;
       [n1_3,n2_3]=swap2(n1_3,n2_3);
       [n1_10,n2_10]=swap2(n1_10,n2_10);
       [n1_20,n2_20]=swap2(n1_20,n2_20);
       [n1_50,n2_50]=swap2(n1_50,n2_50);
       [n1_80,n2_80]=swap2(n1_80,n2_80);
       [n1_100,n2_100]=swap2(n1_100,n2_100);
       [n1_200,n2_200]=swap2(n1_200,n2_200);
       [n1_300,n2_300]=swap2(n1_300,n2_300);
       [n1_400,n2_400]=swap2(n1_400,n2_400);
       [n1_500,n2_500]=swap2(n1_500,n2_500);
       [n1_600,n2_600]=swap2(n1_600,n2_600);
       [n1_700,n2_700]=swap2(n1_700,n2_700);
       [n1_800,n2_800]=swap2(n1_800,n2_800);
       [n1_900,n2_900]=swap2(n1_900,n2_900);
       [n1_1000,n2_1000]=swap2(n1_1000,n2_1000);
       [n1_1100,n2_1100]=swap2(n1_1100,n2_1100);
       [n1_1200,n2_1200]=swap2(n1_1200,n2_1200);
       [n1_1300,n2_1300]=swap2(n1_1300,n2_1300);
       [n1_1400,n2_1400]=swap2(n1_1400,n2_1400);
       [n1_1500,n2_1500]=swap2(n1_1500,n2_1500);
    end
end

%% Generate the PSF and convolution

xx=-1:0.02:1; %pixel size 20nm
PSFX=gaussmf(xx,[0.095 0]);   %fwhm=223.8nm for 0.095
PSFXY=PSFX'*PSFX;
jj3=conv2(aa3,PSFXY);  %image convolution
jj10=conv2(aa10,PSFXY);
jj20=conv2(aa20,PSFXY);
jj50=conv2(aa50,PSFXY);
jj80=conv2(aa80,PSFXY);
jj100=conv2(aa100,PSFXY);
jj200=conv2(aa200,PSFXY);
jj300=conv2(aa300,PSFXY);
jj400=conv2(aa400,PSFXY);
jj500=conv2(aa500,PSFXY);
jj600=conv2(aa600,PSFXY);
jj700=conv2(aa700,PSFXY);
jj800=conv2(aa800,PSFXY);
jj900=conv2(aa900,PSFXY);
jj1000=conv2(aa1000,PSFXY);
jj1100=conv2(aa1100,PSFXY);
jj1200=conv2(aa1200,PSFXY);
jj1300=conv2(aa1300,PSFXY);
jj1400=conv2(aa1400,PSFXY);
jj1500=conv2(aa1500,PSFXY);
long=length(jj3);
%add 3 types of noise (shot noise, fixed pattern noise and read noise)
matrix0={ aa3 aa10 aa20 aa50 aa80 aa100 aa200 aa300 aa400 aa500 aa600 aa700 aa800 aa900 aa1000 aa1100 aa1200 aa1300 aa1400 aa1500};
matrix={ jj3 jj10 jj20 jj50 jj80 jj100 jj200 jj300 jj400 jj500 jj600 jj700 jj800 jj900 jj1000 jj1100 jj1200 jj1300 jj1400 jj1500};
for index=1:20;
    jj=matrix(index);
    aa=matrix0(index);
shot_noise=zeros(long);
fixed_pattern=zeros(long);
jj_noise=zeros(long);
shot_noise_2=zeros(long);
fixed_pattern_2=zeros(long);
jj_noise_2=zeros(long);

%% Add noises

for i=1:long;
    for j=1:long;
        x=jj{1}(i,j)/15;    
        if x>30;
        shot_noise(i,j)=0.04872.*x-3.23164E-5.*x.^2+1.18733E-8.*x.^3-2.17078E-12.*x.^4+1.89132E-16.*x.^5-6.25157E-21.*x.^6+2.28213; %shot noise    fixed_pattern(i,j)=0.00197.*x+4.22038E-6.*x.^2-1.62724E-9.*x.^3+2.69834E-13.*x.^4-1.33659E-17.*x.^5-1.02041E-21.*x.^6+9.13156E-26.*x.^7+1.02107; %fixed pattern noise
read_noise=1.5; %read noise   jj_noise(i,j)=0.72*x+poissrnd(shot_noise(i,j))+normrnd(fixed_pattern(i,j),fixed_pattern(i,j))+normrnd(read_noise,read_noise);  %sCMOS           shot_noise_2(i,j)=0.13016.*x-2.23549E-4.*x.^2+1.95631E-7.*x.^3-5.94507E-11.*x.^4+2.32752;     fixed_pattern_2(i,j)=0.0095.*x-3.47218E-5.*x.^2+4.2948E-8.*x.^3-1.53067E-11.*x.^4+0.08475;
read_noise_2=0.47; %read noise EMCCD  jj_noise_2(i,j)=0.9*x+poissrnd(shot_noise_2(i,j))+normrnd(fixed_pattern_2(i,j),fixed_pattern_2(i,j))+normrnd(read_noise_2,read_noise_2);   %EMCCD
else
shot_noise(i,j)=0.44284.*x-0.02481.*x.^2+4.9109E-4.*x.^3+0.28147;
fixed_pattern(i,j)=0.08148.*x-0.00157.*x.^2+0.45867;
read_noise=1.5;     jj_noise(i,j)=0.72*x+poissrnd(shot_noise(i,j))+normrnd(fixed_pattern(i,j),fixed_pattern(i,j))+normrnd(read_noise,read_noise);  %sCMOS
shot_noise_2(i,j)=0.33164.*x-0.00832.*x.^2+1.24369E-4.*x.^3+1.17655;
fixed_pattern_2(i,j)=0.0107.*x-1.99629E-4.*x.^2+7.37396E-6.*x.^3+0.05949;
read_noise_2=0.47;  jj_noise_2(i,j)=0.9*x+poissrnd(shot_noise_2(i,j))+normrnd(fixed_pattern_2(i,j),fixed_pattern_2(i,j))+normrnd(read_noise_2,read_noise_2);   %EMCCD
        end
    end
end
matrix4=[3 10 20 50 80 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500];
filepath1=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\target\');
mkdir(filepath1);
filepath2=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\without noise\');
mkdir(filepath2);
filepath3=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\sCMOS\');
mkdir(filepath3);
filepath4=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\EMCCD\');
mkdir(filepath4);
imwrite(uint16(aa{1}),[filepath1 int2str(frame) '.tif']);
imwrite(uint16(imresize(jj{1},20/65)),[filepath2 int2str(frame) '.tif']);
imwrite(uint16(imresize(jj_noise,20/65)),[filepath3 int2str(frame) '.tif']);  
imwrite(uint16(imresize(jj_noise_2,20/65)),[filepath4 int2str(frame) '.tif']);
end
end

%% Convert to image stacks

InputFilepath=cd;
for index2=1:20;
    for ff=1:2;
matrix4=[3 10 20 50 80 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500];
filepath3=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index2)),'\sCMOS\');
filepath4=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index2)),'\EMCCD\');
matrix5={filepath3 filepath4};
FILEPATH=matrix5(ff);
outputFileName='stack.tif';
for K=51:150
    img=imread([FILEPATH num2str(K,'%02d') '.tif']);
    imwrite(img, outputFileName, 'WriteMode', 'append',  'Compression','none');
end
    end
end
