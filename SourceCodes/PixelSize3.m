%% Calculate the cutoff frequencies for different pixel sizes


clear all,close all
clc
cutoff_freq=zeros(1,16);  %index==16;
for index=1:16;
clearvars -except index cutoff_freq
InputFilepath=cd;
matrix=[20 40 60 65 80 100 108 120 140 160 180 200 220 240 260 267];
filepath=strcat(InputFilepath,'\conv_target\');
filepath_read1=strcat(filepath,'spatial_freq',num2str(matrix(index)),'.mat');
filepath_read2=strcat(filepath,'corr_value',num2str(matrix(index)),'.mat');
spatial_freq=load(filepath_read1);
corr_value=load(filepath_read2);
spatial_freq=spatial_freq.spatial_freq;
corr_value=corr_value.corr_value;
for ss=1:length(corr_value)
    if corr_value(ss)<=0.2;
        cutoff_freq(index)=spatial_freq(ss);   %calculate cutoff frequency
        break;
    end
end
   
end
figure(1)
plot(matrix,cutoff_freq)  %plot cutoff frequency vs. pixel size
saveas(gcf,strcat(filepath,'result\','cutoff-pixelsize.jpg'));
xlswrite (strcat(filepath,'result\PixelSize'),matrix);
xlswrite (strcat(filepath,'result\Cutoff_freq'),cutoff_freq);

