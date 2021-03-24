% %visualize.m
% %visualize a signal from the .mat file
% %visualize single channel reference https://www.youtube.com/watch?v=GzavKiHXilo
% clc
% load('./WFDB_Ga/E08276.hea');
% [recording,Total_time,num_leads,Fs,adc_gain,age_data,sex_data,Baseline]=extract_data_from_header(val);
% load('./WFDB_Ga/E08276.mat');
% ECGSignal = val;
% %Fs = 360;
% t = (0:length(ECGSignal)-1)/Fs;
% plot(t, ECGSignal);

%plot(EKG(3,1:900))

% lets assume Fs=360
Fs = 360;
samples = 900;
t = (0:samples-1)/Fs;
EKGD = load('./WFDB_Ga/E08276.mat');
EKG = EKGD.val;
Leadc = {'I','II','III','aV_R','aV_L','aV_F','V_1','V_2','V_3','V_4','V_5','V_6'};
figure
kc = 1;
for k1 = 1:4
    for k2 = 1:4:9
        sbpt = (k1-1)+k2;
        subplot(3,4,sbpt)
        %plot(EKG(1:300,kc))
        disp(kc)
        plot(EKG(kc,1:samples))
        title(Leadc{kc})
        grid
        ylim([-1000 1000])
        kc = kc+1;
    end
end



