% %visualize.m
% %visualize a signal from the .mat file
% %visualize single channel reference https://www.youtube.com/watch?v=GzavKiHXilo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
% Visual signals extracted from the signal directories
%
% Inputs:
%
% Outputs:
% 
% Author: Zade, Ashutosh (C) 2021 ashutosh.zade@hec.edu
% Version 2.0
% Date March 26, 2001
% Version 2.0 March 28, 2021
%
% Copyright: BSD 2-Clause License
%
% Notes
% ECGSignal = val;
% %Fs = 360;
% t = (0:length(ECGSignal)-1)/Fs;
% plot(t, ECGSignal);
% plot(EKG(3,1:900))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function visualize()

Leadc = {'I','II','III','aV_R','aV_L','aV_F','V_1','V_2','V_3','V_4','V_5','V_6'};
tmp_input_file='WFDB_Ga/E08276';

[data,hea_data] = load_challenge_data(tmp_input_file);

[recording,Total_time,num_leads,Fs,adc_gain,age_data,sex_data,Baseline] = extract_data_from_header(hea_data);
 
disp(['Frequency' Fs]);
disp(Total_time);
disp(recording);
disp(adc_gain);
disp(age_data);
disp(sex_data);
disp(num_leads);
disp(Baseline);

window = 999;
EKG = data;

visualize_time_domain(Fs, window, EKG, Leadc);
visualize_freq_domain(Fs, window, EKG);

end

%
%visualize signals on time domain
%
function visualize_time_domain(Fs, window, EKG, Leadc)
figure
kc = 1;
t = (0:window-1)/Fs;
for k1 = 1:4
    for k2 = 1:4:9
        sbpt = (k1-1)+k2;
        subplot(3,4,sbpt)
        %disp(kc)
        plot(EKG(kc,1:window))
        title(Leadc{kc})
        grid
        ylim([-1000 1000])
        kc = kc+1;
    end
end

end

%
% Get challenge data from header file associated with each .mat file
%
function [data,tlines] = load_challenge_data(filename)

fileext = append(filename, '.hea');
disp(fileext);

fid=fopen(fileext);
if (fid<=0)
    disp(['error in opening file ' filename]);
end

tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

mfileext = append(filename, '.mat');
f=load(mfileext);

try
    data = f.val;
catch ex
    rethrow(ex);
end

end

%
% visualize signal on frequency domain using cwt
%
function visualize_freq_domain(Fs, window, EKG)

fb = cwtfilterbank('SignalLength',window,...
    'SamplingFrequency',Fs,...
    'VoicesPerOctave',12);
    
sig = EKG(1,1:window);
[cfs,frq] = wt(fb,sig);
t = (0:window-1)/Fs;
figure;
pcolor(t,frq,abs(cfs))
set(gca,'yscale','log');shading interp;axis tight;
title('Scalogram');xlabel('Time (s)');ylabel('Frequency (Hz)')

end

