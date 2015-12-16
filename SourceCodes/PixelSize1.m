%--------------------------------------------------------------------------
% Source code for generating stacks of blinking frames with different pixel sizes
% Copyright 2015 Zhiping Zeng
%--------------------------------------------------------------------------
%% Read resolution target file

close all;
clc
InputFilepath=cd;
pixelnumber=452;
aa=zeros(pixelnumber);
resolution_target_3=imread('resolution_target_3.tif');
[row, col] = find( resolution_target_3 > 100 );   
num = size(row, 1);           
bb=aa;
for i = 1:1:num                
    bb(row(i), col(i)) = 1;     
end
imshow(bb,[])

%% Generate power law blinking

n1=5;
n2=0;
C = zeros(num,2*3000);
for n=1:1:num              
alpha=1.5;
alpha_off=1.9;
dmax=1;
frame_time=0.03; % s
xx=rand(1,3000);
ton1 = 0.01*exp(log(dmax)-log(xx)./alpha);    %on time power law
frame_on1 = ceil(ton1/frame_time);
xx=rand(1,3000);
toff1 = 0.01*exp(log(dmax)-log(xx)./alpha_off);  %off time power law
frame_off1 = 2*ceil(toff1/frame_time);
C(n,1:2:end) = frame_on1;
C(n,2:2:end) = frame_off1;
end  
a=ones(1,num);
for frame=1:600
    for m=1:1:num
    if C(m,a(m))>0
       aa(row(m), col(m))  = n1;
        C(m,a(m))=C(m,a(m))-1;
    else aa(row(n), col(n))  = n2;
        a(m)=a(m)+1;
        temp1=n1;
        n1=n2;
        n2=temp1;        
    end
    end
    
%% Convolution with PSF

xx=-1:0.02:1; %pixel size 20nm
PSFX=gaussmf(xx,[0.095 0]);   %fwhm=223.8nm for 0.095
PSFXY=PSFX'*PSFX; 
jj=conv2(aa,PSFXY);  %image convolution
jj20=imresize(jj,20/20);   %image resize to generate different pixel sizes
jj40=imresize(jj,20/40);
jj60=imresize(jj,20/60);
jj80=imresize(jj,20/80);
jj100=imresize(jj,20/100);
jj120=imresize(jj,20/120);
jj140=imresize(jj,20/140);
jj160=imresize(jj,20/160);
jj180=imresize(jj,20/180);
jj200=imresize(jj,20/200);
jj220=imresize(jj,20/220);
jj240=imresize(jj,20/240);
jj260=imresize(jj,20/260);
jj65=imresize(jj,20/65);
jj108=imresize(jj,20/108);
jj267=imresize(jj,20/267);
matrix=[20 40 60 80 100 120 140 160 180 200 220 240 260 65 108 267];
jjj={jj20 jj40 jj60 jj80 jj100 jj120 jj140 jj160 jj180 jj200 jj220 jj240 jj260 jj65 jj108 jj267};
length_matrix=length(matrix);
for nn=1:length_matrix
jjj{nn}=jjj{nn}.*(matrix(nn)^2/100^2);  %control photon budget
% Add shot noise.
len=length(jjj{nn});
shotnoise=zeros(len,len);
shotnoise_sigma=sqrt(jjj{nn});   
 for x=1:len
     for y=1:len
         shotnoise(x,y)=poissrnd(shotnoise_sigma(x,y)); %shot noise follows Poisson
     end
 end
jjj{nn}=jjj{nn}+shotnoise;
figure(2)
imshow(jjj{nn},[]);pause(0.01)

filepath=strcat(InputFilepath,'\RawData-PixelSize\',num2str(matrix(nn)),'\');
mkdir(filepath);
imwrite(uint16(jjj{nn}),[filepath int2str(frame) '.tif']);
end
end

%% Convert to image stacks
matrix=[20 40 60 80 100 120 140 160 180 200 220 240 260 65 108 267];
for P=1:16
    
filepath2=strcat(InputFilepath,'\RawData-PixelSize\',num2str(matrix(P)),'\');
outputFileName='stack.tif';
for K=101:600
    img=imread([filepath2 num2str(K) '.tif']);
    imwrite(img, [filepath2 outputFileName], 'WriteMode', 'append',  'Compression','none');
end
end