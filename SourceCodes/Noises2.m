%% Calculate the cutoff frequencies for different noise levels

clear all,close all
clc
InputFilepath=cd;
conv_target=double(imread('conv_target_3rd_for_65nm.tif'));
conv_target=conv_target./max(max(conv_target));
conv_target=conv_target-0.5;
MTF_no_noise=zeros(1,20);  
MTF_sCMOS=zeros(1,20);
MTF_EMCCD=zeros(1,20);
matrix0={MTF_sCMOS MTF_EMCCD};
for index=1:20;
    for f=1:2;
matrix4=[3 10 20 50 80 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500];
filepath3=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\sCMOS\');
filepath4=strcat(InputFilepath,'\RawData-Noises\','photon-',num2str(matrix4(index)),'\EMCCD\');
matrix5={filepath3 filepath4};
filepath=matrix5(f);
filepath_read=strcat(filepath{1},'3.tif');
I=double(imread(filepath_read));
I=I./max(max(I));
I=I-0.5;
[x,y]=size(I);
M=x;
ny=repmat(1:M,M,1);
nx=ny';
xpos=(nx)-M/2;
ypos=(ny)-M/2;
[theta,rr]=cart2pol(xpos,ypos);  %Cartesian coordinate transform to polar coordinate
count0=0;
pixel_size=0.022; %pixe size is 22 nm
for radius=150:-2:20;  % specify radius
    count0=count0+1;
    J=I;
    conv_target2=conv_target;
    count=0;
for a=1:M;
    for b=1:M;
        if rr(a,b)>=radius-0.7&&rr(a,b)<radius+0.7;
            count=count+1;
            aa(count)=a;
            bb(count)=b;
        end
    end
end
for h=1:M;
    for k=1:M;
        count2=0;
        for c=1:count
       if h==aa(c)&&k==bb(c);
       else count2=count2+1;
       end
        end
        if count2==count;
           J(h,k)=0;
           conv_target2(h,k)=0;
        end
    end
end
profile=zeros(1,count);   %calculate circular profiles
profile_target=zeros(1,count); 
for p=1:count;
    profile(p)=J(aa(p),bb(p));
    profile_target(p)=conv_target2(aa(p),bb(p));
end
[temp,temp2]=corrcoef(profile,profile_target);  %calculate correlation coefficient
corr_value(count0)=temp(1,2);
p_value(count0)=temp2(1,2);
spatial_freq(count0)=36/(2*pi*radius*pixel_size);  %period/um
end
figure(1)
plot(spatial_freq,corr_value)  %plot cutoff frequency vs. correlation value curve
saveas(gcf,strcat(filepath{1},'curve.jpg'));
figure(2)
plot(spatial_freq,p_value)
saveas(gcf,strcat(filepath{1},'curve_p_value.jpg'));
save (strcat(filepath{1},'spatial_freq.mat'),'spatial_freq');
save (strcat(filepath{1},'corr_value.mat'),'corr_value');
save (strcat(filepath{1},'p_value.mat'),'p_value');
xlswrite (strcat(filepath{1},'spatial_freq'),spatial_freq);
xlswrite (strcat(filepath{1},'corr_value'),corr_value);
xlswrite (strcat(filepath{1},'p_value'),p_value)
for ss=1:length(p_value)
    if corr_value(ss)<=0.2;
        matrix0{f}(index)=spatial_freq(ss);  %calculate cutoff frequency
        break;
    end
end
    end
end
figure(2)
plot(matrix4,matrix0{1},'r')  %plot cutoff frequency vs. photon number curve for sCMOS
hold on
plot(matrix4,matrix0{2},'b')  %plot cutoff frequency vs. photon number curve for EMCCD
saveas(gcf,strcat(InputFilepath,'\RawData-Noises\','corr_value_all.jpg'));
xlswrite (strcat(InputFilepath,'\RawData-Noises\','Photons'),matrix4);
xlswrite (strcat(InputFilepath,'\RawData-Noises\','sCMOS'),matrix0{1});
xlswrite (strcat(InputFilepath,'\RawData-Noises\','EMCCD'),matrix0{2});

