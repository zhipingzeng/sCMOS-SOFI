%--------------------------------------------------------------------------
% Calculate the curve of correlation value versus spatial frequency with different pixel sizes
% Copyright 2015 Zhiping Zeng
%--------------------------------------------------------------------------

%% Calculate image correlation functions

clear all,close all
clc
for index=1:16
clearvars -except index
close all
matrix=[20 40 60 80 100 120 140 160 180 200 220 240 260 65 108 267];
InputFilepath=cd;
conv_target=double(imread(strcat(InputFilepath,'\conv_target\3rd-',num2str(matrix(index)),'.tif')));
conv_target=conv_target./max(max(conv_target));
conv_target=conv_target-0.5;
filepath=strcat(InputFilepath,'\conv_target\');
filepath_read=strcat(filepath,'conv_target_3rd_for_',num2str(matrix(index)),'nm.tif');
I=imread(filepath_read);
I=double(imread(filepath_read));
I=I./max(max(I));
I=I-0.5;
[x,y]=size(I);
M=x;
ny=repmat(1:M,M,1);
nx=ny';
xpos=(nx)-M/2;
ypos=(ny)-M/2;
[theta,rr]=cart2pol(xpos,ypos); %Cartesian coordinate transform to polar coordinate
count0=0;
pixel_size=499/length(conv_target)*0.022; 
for radius=round(150*0.022/pixel_size):-2:round(20*0.022/pixel_size);  % specify radius
    count0=count0+1;
    J=I;
    conv_target2=conv_target;
    count=0;
    display(radius)
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
[temp,temp2]=corrcoef(profile,profile_target);    %calculate correlation coefficient
corr_value(count0)=temp(1,2);
p_value(count0)=temp2(1,2);
spatial_freq(count0)=36/(2*pi*radius*pixel_size);  %period/um
end
figure(1)
plot(spatial_freq,corr_value)  %plot correlation value vs. spatial frequency curve
saveas(gcf,strcat(filepath,'curve_correlation',num2str(matrix(index)),'.jpg'));
figure(2)
plot(spatial_freq,p_value)
saveas(gcf,strcat(filepath,'curve_p_value',num2str(matrix(index)),'.jpg'));
save (strcat(filepath,'spatial_freq',num2str(matrix(index)),'.mat'),'spatial_freq');
save (strcat(filepath,'corr_value',num2str(matrix(index)),'.mat'),'corr_value');
save (strcat(filepath,'p_value',num2str(matrix(index)),'.mat'),'p_value');
xlswrite (strcat(filepath,'spatial_freq',num2str(matrix(index))),spatial_freq);
xlswrite (strcat(filepath,'corr_value',num2str(matrix(index))),corr_value);
xlswrite (strcat(filepath,'p_value',num2str(matrix(index))),p_value)
end

